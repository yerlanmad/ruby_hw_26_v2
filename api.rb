# frozen_string_literal: true

class Api < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api/v1' do
    before do
      content_type 'application/json'
    end

    helpers do
      def base_url
        @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
      end

      def json_params
        JSON.parse(request.body.read)
      rescue JSON::ParserError
        halt 400, { message: 'Invalid JSON' }.to_json
      end

      def station
        @station ||= Station.where(id: params[:id]).first
      end

      def route
        @route ||= Route.where(id: params[:id]).first
      end

      def train
        @train ||= Train.where(id: params[:id]).first
      end

      def halt_if_not_found!(record)
        halt(404, { message: 'Record Not Found' }.to_json) unless record
      end
    end

    get '/stations' do
      stations = Station.all
      stations.to_json
    end

    get '/stations/:id' do
      halt_if_not_found!(station)
      station.to_json
    end

    post '/stations' do
      station = Station.new(json_params)
      halt 422, station.errors.to_json unless station.save

      response.headers['Location'] = "#{base_url}/api/v1/stations/#{station.id}"
      status 201
    end

    get '/routes' do
      routes = Route.all
      routes.map { |route| RouteSerializer.new(route) }.to_json
    end

    get '/routes/:id' do
      halt_if_not_found!(route)
      route.to_json
    end

    post '/routes' do
      route = Route.new(json_params)
      halt 422, route.errors.to_json unless route.save

      response.headers['Location'] = "#{base_url}/api/v1/routes/#{route.id}"
      status 201
    rescue SearchError => e
      halt(404, { message: e }.to_json)
    end

    get '/trains' do
      trains = Train.all
      trains.to_json
    end

    get '/trains/:id' do
      halt_if_not_found!(train)
      train.to_json
    end

    post '/trains' do
      train = Train.new(json_params)
      halt 422, train.errors.to_json unless train.save

      response.headers['Location'] = "#{base_url}/api/v1/trains/#{train.id}"
      status 201
    end

    patch '/trains/:id' do
      halt_if_not_found!(train)

      train.update_attributes(json_params)
      train.to_json
    end

    patch '/trains/:id/route/:route_id' do
      halt_if_not_found!(train)

      train.accept_route(params[:route_id])
      train.to_json
    rescue SearchError => e
      halt(404, { message: e }.to_json)
    end
  end
end
