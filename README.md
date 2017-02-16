# DAETSIINF PRINTING
Rails JSON API used as backend for the [Student Nation of the Computer Science School UPM](http://da.etsiinf.upm.es) printing system.

## Endpoints
List of endpoints and documentation related to them:

|  |Endpoint | Method | Definition |
| --- | --- | --- | --- |
| 1 | /users | POST | Creates a user |
| 2 | /folders | POST | Creates a folder |
| 3 | /documents | POST | Creates a document |
| 4 | /sessions | POST | Logs in a user |

There are certain **headers** that need to be included in the requests in order to obtain a succesfull answer from the API:

```HTTP
Accept: vnd.daetsiinf_printing.v1
Content-type: application/json
```

In some circumstances an **Authorization** header needs to be included in order to verify the user authenticity:

```HTTP
Authorization: <USER_AUTH_TOKEN>
```

### Creating a user.
To create a user we need to issue a POST request to `/users` with the following body:

```json
{
	"user": {
		"name": "FULL NAME",
		"email": "VALID EMAIL",
		"password": "PASSWORD",
		"password_confirmation": "PASSWORD"
	}
}
```

This requests returns a new user with all the shared folders and documents, like following:

```json
{
  "id": 1,
  "name": "FULL NAME",
  "email": "VALID EMAIL",
  "auth_token": "USER_AUTH_TOKEN",
  "balance": 0,
  "folders": [],
  "documents": []
}
```

### Creating a folder.
### Creating a document.
### Logging a user.
