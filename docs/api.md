## Authentication

### Registration

**POST /api/v1/sign_up**

Sample Request:
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

Sample Response:

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

Sample Request:
```
{
  "email": "name@domain.com",
  "password": "secret"
}
```

Sample Response:
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
| id    | id of the Category item in database, used to identify the category upon creation of a record |
| name  | name of category                                                                             |
| icon  | relative path of image icon (ie. to fetch the image, prepend the BASE_URL)                   |


## Records

### Create

### Fetch all

**GET /api/v1/records**


Sample Response:

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
### Overview

### Update

### Delete