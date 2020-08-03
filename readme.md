>GET http://localhost:4567/api/v1/stations

Returns JSON list of stations

Content-Type: `application/json`
```
[
  {
    "_id": {
      "$oid": string # station id
    },
    "name": string, # station name
    "trains": [] # list of trains id
  }
]
```

>GET http://localhost:4567/api/v1/stations/:id

Path parameters

`:id` - id of station

Returns JSON object of station

Content-Type: `application/json`
```
{
  "_id": {
    "$oid": string # station id
  },
  "name": string, # station name
  "trains": [] # list of trains id
}
```

>POST http://localhost:4567/api/v1/stations

Accept: `application/json`
```
{
  "name": string, # station name, required parameter
  "trains": [] # list of trains id
}
```
Returns `HTTP 201 Created` with the resource URL in the `Location` hea

>GET http://localhost:4567/api/v1/routes

Returns JSON list of routes

Content-Type: `application/json`
```
[
  {
  "id": string, # route id
  "name": string, # route name
  "stations": [
    {
    "name": string, # station name
    "trains": [
      {
      "number": string, # train number
      "type": string, # train type
      "wagons_amount": number # wagon amount
      }
    ]
    }
  ]
  }
]
```

>GET http://localhost:4567/api/v1/routes/:id

Path parameters

`:id` - id of route

Returns JSON object of route

Content-Type: `application/json`
```
{
  "_id": {
    "$oid": string # station id
  },
  "name": string, # station name
  "stations": [] # list of stations id
}
```

>POST http://localhost:4567/api/v1/routes

Accept: `application/json`
```
{
  "first_station": string, # first station id, required parameter
  "last_station": string # last station id, required parameter
}
```
Returns `HTTP 201 Created` with the resource URL in the `Location` header 

>
>GET http://localhost:4567/api/v1/trains

Returns JSON list of trains

Content-Type: `application/json`
```
[
  {
    "_id": {
      "$oid": string # train id
    },
    "number": string, # train number
    "route": string, # route id
    "type": string, # train type
    "wagons": [] # list of wagons id
  }
]
```

>
>GET http://localhost:4567/api/v1/trains/:id

Path parameters

`:id` - id of train

Returns JSON object of train

Content-Type: `application/json`
```
{
  "_id": {
    "$oid": string # train id
  },
  "number": string, # train number
  "route": string, # route id
  "type": string, # train type
  "wagons": [] # list of wagons id
}
```

>
>POST http://localhost:4567/api/v1/trains

Accept: `application/json`
```
{
  "number": string, # train number, required parameter
  "route": string, # route id
  "type": string, # train type, required parameter
  "wagons": [] # list of wagons id
}
```
Returns `HTTP 201 Created` with the resource URL in the `Location` header

>
>PATCH http://localhost:4567/api/v1/trains/:id/route/:route_id

Path parameters

`:id` - id of train

`:route_id` - id of route

Returns JSON object of train

Content-Type: `application/json`
```
{
  "_id": {
    "$oid": string # train id
  },
  "number": string, # train number
  "route": string, # route id
  "type": string, # train type
  "wagons": [] # list of wagons id
}
```
