# Table of Contents
- [What is REST?](#what-is-rest-)
- [Authentication](#authentication)
  * [Registration](#registration)
  * [Login](#login)
- [Categories](#categories)
  * [Fetching categories](#fetching-categories)
- [Records](#records)
  * [Authentication](#authentication-1)
  * [Create](#create)
  * [Fetch all](#fetch-all)
  * [Update](#update)
  * [Delete](#delete)
  * [Overview](#overview)
  * [Seed](#seed)


## What is REST? 

[Here](https://www.smashingmagazine.com/2018/01/understanding-using-rest-api/) is a great introduction to REST API and how to use it.

We usually use [Postman](https://www.postman.com/) to send raw API requests to the server for testing. 


## Authentication

### Registration

**POST /api/v1/sign_up**

#### Sample Request:

```
{
  "name": "Your Name",
  "email": "name@domain.com",
  "password": "secret"
}
```

| Parameter | Description                         |
|-----------|-------------------------------------|
| name      |                                     |
| email     | User's email, cannot be a duplicate |
| password  |                                     |

#### Sample Response:

*Success*
```
{
    "message": "Successfully signed up!",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.KW6Tw0QduYObOpy7279iR3DC8gjqWzSYtSfg1Vb4u8g",
    "user": {
        "id": 1,
        "email": "name@domain.com",
        "name": "Your Name"
    }
}
```

*Error*
```
{
    "error": "Validation failed: Email has already been taken"
}
```

### Login

**POST /api/v1/sign_in**

#### Sample Request:
```
{
  "email": "name@domain.com",
  "password": "secret"
}
```

#### Sample Response:

*Success*
```
{
    "message": "Successfully signed in!",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.KW6Tw0QduYObOpy7279iR3DC8gjqWzSYtSfg1Vb4u8g",
    "user": {
        "id": 1,
        "email": "name@domain.com",
        "name": "Your Name"
    }
}
```

*Error*
```
{
    "error": "Please check your email or password."
}
```


==============


## Categories

### Fetching categories

**GET /api/v1/categories**

There are no supported parameters for this endpoint.

Sample Response:

```
{
    "categories": [
        {
            "id": 1,
            "name": "Food & Drinks",
            "icon": "/images/ic_food_drinks.png"
        },
        {
            "id": 2,
            "name": "Groceries",
            "icon": "/images/ic_groceries.png"
        },
        ...
        {
            "id": 14,
            "name": "Other",
            "icon": "/images/ic_other.png"
        }
    ]
}
```

| Field | Description                                                                                  |
|-------|----------------------------------------------------------------------------------------------|
| id    | used to identify the category upon creation of a record |
| name  | name of category                                                                             |
| icon  | relative path of image icon (ie. to fetch the image, prepend the BASE_URL)                   |


==============


## Records

### Authentication

For all of the following methods, the request must have a Bearer Authorization header, otherwise the calls will fail with an Unauthorized error. The Bearer token is of the format `Bearer <token>` where `token` is returned in a successful registration or login call. (Read more on how to make authenticated calls on Flutter [here](https://flutter.dev/docs/cookbook/networking/authenticated-requests).)


### Create

#### Sample Request

**POST /api/v1/records**

```
{
  "record": {
    "amount": 100.00,
    "notes": "New expense",
    "record_type": 0,
    "date": "2020-06-01T00:00:00.000Z",
    "category_id": 1
  }
}
```

| Parameter   | Description                                                                |
|-------------|----------------------------------------------------------------------------|
| record_type | `0` - income, `1` - expense                                                |
| category_id | must match any of the category ids returned in the /api/v1/categories call |



#### Sample Response:

```
{
    "id": 19,
    "date": "2020-06-01T00:00:00.000Z",
    "notes": "New expense",
    "category": {
        "id": 1,
        "name": "Food & Drinks"
    },
    "amount": 100,
    "record_type": 0
}
```

### Fetch all

This method will return a list of records ordered by date descending, so the latest records (according to the `date` specified) will appear first. 

The response is paginated; each call will return a maximum of 10 records.

#### Sample Request

**GET /api/v1/records**

Below are optional parameters you can append to the request, eg. `GET /api/v1/records?q=Jollibee` will return all records with "Jollibee" in the notes.

| Parameter | Description                                                             |
|-----------|-------------------------------------------------------------------------|
| page      | offset the list of records by `page` amount                             |
| limit     | fetch the first `limit` records, if present disregards `page` parameter |
| q         | query the `notes` fields of the Record table                            |


#### Sample Response:

```
{
    "records": [
        {
            "id": 141,
            "date": "2020-06-04T00:00:00.000Z",
            "notes": "Seeded record",
            "category": {
                "id": 6,
                "name": "Gifts"
            },
            "amount": 18997,
            "record_type": 1
        },
        ...
        {
            "id": 131,
            "date": "2020-05-26T00:00:00.000Z",
            "notes": "Seeded record",
            "category": {
                "id": 2,
                "name": "Groceries"
            },
            "amount": 10785,
            "record_type": 0
        }
    ],
    "pagination": {
        "current_url": "/api/v1/records",
        "next_url": "/api/v1/records?page=2",
        "previous_url": "/api/v1/records?page=1",
        "current": 1,
        "per_page": 10,
        "pages": 4,
        "count": 31
    }
}
```

### Update

#### Sample Request

**PATCH /api/v1/records/:id**

```
{
  "record": {
    "amount": 120.00,
    "notes": "Updated expense",
    "record_type": 0,
    "date": "2020-06-01T00:00:00.000Z",
    "category_id": 1
  }
}
```

This accepts essentially the same parameters as the Create method above. The `:id` substring must be replaced with the id of the record you are trying to update, eg. `PATCH /api/v1/records/123`.


#### Sample Response:

```
{
    "id": 19,
    "date": "2020-06-01T00:00:00.000Z",
    "notes": "Updated expense",
    "category": {
        "id": 1,
        "name": "Food & Drinks"
    },
    "amount": 120,
    "record_type": 0
}
```

### Delete

#### Sample Request

**DELETE /api/v1/records/:id**

The `:id` substring must be replaced with the id of the record you are trying to delete, eg. `DELETE /api/v1/records/123`.

#### Sample Response:

```
{
    "message": "Record successfully deleted."
}
```


### Overview

This method will return the total income and expenses for the account for all time. This is used for the display of graphs.


#### Sample Request

**GET /api/v1/records/overview**


#### Sample Response:

```
{
    "income": 201691.00,
    "expenses": 106947.00
}
```


### Seed

This is a quick way to add a large amount of records to the database for the currently logged-in user, ie. useful if you want to test pagination.


#### Sample Request

**GET /api/v1/records/seed**

Accepts an optional parameter `num`.

| Parameter   | Description                                                                |
|-------------|----------------------------------------------------------------------------|
| num         | number of records to add, defaults to 10 if unspecified                    |

**!! WARNING !!** Specifying a large `num` will cause the server to slow down. Please use with discretion.


#### Sample Response:

```
{
    "message": "Records seeded successfully!"
}
```