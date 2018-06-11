# TuAplicación Prueba

Solición a la prueba técnica Ruby On Rails API REST de usuarios y sus intereses.

## Problemática
Se solicita desarrollar en el lenguaje ruby una serie de endpoints arquitectura REST que permitan administrar la información de usuarios y gestionar los intereses de los mismos.

## Solución
Se desarrolla un aplicativo usando el framework rails. Cuenta con un modelo usuario y una asoción con un modelo de intereses de tal forma que un usuario pude tener muchos intereses (one to many). Ambos modelos cuentan con sus respectivos endpoints en una rest api con restricción de autenticación y una interfaz web que permite ver la información almacenada.

La estructura utilizada permite versionamiento de la api.

Interfaz gráfica para visualizar la información almacenada.

![alt text](https://lh3.googleusercontent.com/VFlglQwGHUHo5bpGpz41w-8yUdK3qcKtfjAd5A4k5BKKUlBF0mEcoyOLLXKMYwVk7o9VqeR5fh0FSA=w1440-h724-rw
 "Dashboard principal")

## Getting Started
Abrir la terminal y clonar el proyecto

```git clone git@github.com:katorres02/tuaplicaciontest.git```

Instalar gemas

```bundle install```

Crear y migrar la base de datos 

```rake db:create db:migrate```

Iniciar el servidor

```rails s```

## Tecnologías base utilizadas
  * ruby 2.3.3
  * rails 5.1.5
  * sqlite3
  * rabl
   
## Ejecución de pruebas Testing
En la terminal del proyecto

* ` rspec ` pruebas a los modelos
* ` rspec spec/controllers/api/v1/*` pruebas a los controladores


## Guía de uso

Información acerca de los webservices endpoints desarrollados.
Los servicios fueron desarrollados de tal forma que soliciten la autenticación del usuario que realiza acciones por medio de credenciales como parámetros dentro de los headers de la petición.

Tener en cuenta que la arquitectura utilizada permite versionamiento de la api, actualmente se usa la versión 1 'v1'.

**A continuación las secciones ó modulos desarrollados.**

### SESIONES
Controlador de sesiones encargado de controlar la autenticación del usuario y entregar o eliminar el **TOKEN** de autenticación.

| ENDPOINTS        | HTTP VERB  | Descripción  |
| ------------- |:-------------:| -----:|
| /api/v1/sessions/login.json | POST | Autentica al usuario ya creado, retorna el **TOKEN** de autenticación |
| /api/v1/sessions/logout.json | DELETE | Elimina el **TOKEN** cerrando la "sesión" del usuario |

### /api/v1/sessions/login.json
**headers:** Ninguno

**params:** 
```json
{ 
  "email": "carlos@mail.com",
  "password": 12345678
}
```

**response:** 
```json
{
  "user": {
      "id": 1,
      "email": "carlos@mail.com",
      "first_name": "carlos",
      "second_name": "andres",
      "last_name": "torres",
      "maiden_name": null,
      "authentication_token": "RPUsF7KR9uTh9By2xVEu"
  }
}
```

### /api/v1/sessions/logut.json
**headers:**
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** Ninguno
**response:**
```json
  {
    "message": "Sesión terminada"
  }
```

### USUARIOS
Controlador de usuarios, gestiona la información del usuario.

| ENDPOINTS        | HTTP VERB  | Descripción  |
| ------------- |:-------------:| -----:|
| /api/v1/users/1.json | GET | Detalle de un usuario específico |
| /api/v1/users.json | POST | Crear un usuario |
| /api/v1/users/1.json | PUT/PATCH | Editar un usuario |
| /api/v1/users/1.json | DELETE | Eliminar un usuario |

### GET /api/v1/users/1.json
**headers:**
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** El identificador(id) del usuario
```json
  {
    "id": 1
  }
```

**response:**
```json
{
  "user": {
      "id": 1,
      "email": "carlos@mail.com",
      "first_name": "carlos",
      "second_name": "andres",
      "last_name": "torres",
      "maiden_name": null,
      "authentication_token": "pYYPPedQ1skMtKUAU61b"
    }
}
```

### POST /api/v1/users.json
**headers:**: Ninguno

**params:** Datos de creación de usuario, los campos email, contraseña y nombre son obligatorios
```json
  {
    "user": {
      "email": "andres@mail.com",
      "password": 12345678,
      "first_name": "andres",
      "second_name": "carlos",
      "last_name": "torres",
      "maiden_name": "cruz"
    }
  }
```

**response:**
```json
{
  "user": {
      "id": 1,
      "email": "carlos@mail.com",
      "first_name": "carlos",
      "second_name": "andres",
      "last_name": "torres",
      "maiden_name": null,
      "authentication_token": "pYYPPedQ1skMtKUAU61b"
    }
}
```

### PUT/PATCH /api/v1/users/1.json
**headers:**:
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** Identificador del usuario en la URL y campos del usuario a editar.
```json
  {
    "id": 1,
    "user": {
      "email": "andres@mail.com",
      "password": 12345678,
      "first_name": "andres",
      "second_name": "carlos",
      "last_name": "torres",
      "maiden_name": "cruz"
    }
  }
```

**response:** objeto usuario con campos editados
```json
{
  "user": {
      "id": 1,
      "email": "carlos@mail.com",
      "first_name": "carlos",
      "second_name": "andres",
      "last_name": "torres",
      "maiden_name": null,
      "authentication_token": "pYYPPedQ1skMtKUAU61b"
    }
}
```

### DELETE /api/v1/users/1.json
**headers:**:
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** Identificador del usuario en la URL
```json
  {
    "id": 1
  }
```

**response:** mensaje de usuario eliminado
```json
{
  "message": "Registro eliminado"
}
```

### INTERESES
Controlador de intereses de usuarios, gestiona los intereses de cada usuario.

Nótese que los resources de usuarios e intereses están anitados en la url.

| ENDPOINTS        | HTTP VERB  | Descripción  |
| ------------- |:-------------:| -----:|
| /api/v1/users/1/interests.json | GET | Lista de intereses de un usuario |
| /api/v1/users/1/interests/1.json | GET | Detalle de un interés específico |
| /api/v1/users/1/interests.json | POST | Crear un interés y asociarlo a un usuario |
| /api/v1/users/1/interests/1.json | PUT/PATCH | Editar un interés de un usuario |
| /api/v1/users/1/interests/1.json | DELETE | Eliminar un interés de un usuario |


### GET /api/v1/users/1/interests.json
**headers:**
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** El identificador(id) del usuario en la url
```json
  {
    "id": 1
  }
```

**response:**
```json
[
    {
        "interest": {
            "id": 3,
            "name": "Arte"
        }
    },
    {
        "interest": {
            "id": 4,
            "name": "Literatura"
        }
    }
]
```

### GET /api/v1/users/1/interests/1.json
**headers:**:
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** ID del usuario y del interés específico en la url
```json
  {
    "id": "$id del intéres",
    "user_id": "$id del usuario"
  }
```

**response:**
```json
{
    "interest": {
      "id": 4,
      "name": "Literatura"
    }
}
```

### POST /api/v1/users/1/interests.json
**headers:**:
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** información del interés que será asociado y el id del usuario.
```json
  {
    "user_id": 1,
    "interest": {
      "name": "nuevo interés"
    }
  }
```

**response:** nuevo interés creado y asociado
```json
  {
    "interest": {
      "name": "nuevo interés"
    }
  }
```


### PUT/PATCH /api/v1/users/1/interests/1.json
**headers:**:
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** Identificador del usuario en la URL y campos del interés a editar.
```json
  {
    "id": 1,
    "user_id": 1,
    "interest": {
      "name": "nuevo nombre"
    }
  }
```

**response:** objeto interés con campos editados
```json
  {
    "interest": {
      "name": "nuevo nombre"
    }
  }
```

### DELETE /api/v1/users/1/interests/1.json
**headers:**:
```json
  {
    "X-User-Email": "carlos@mail.com",
    "X-User-Token": "RPUsF7KR9uTh9By2xVEu"
  }
```

**params:** Identificador del usuario en la URL y el identificador del interés a eliminar
```json
  {
    "id": 1,
    "user_id": 1
  }
```

**response:** mensaje de interés eliminado
```json
{
  "message": "Registro eliminado"
}
```
## Seguimiento de datos
La vista principal del proyecto muestra la lista de usuarios con la información almacenada a través de los servicios. Se puede ver los datos básicos del usuario y la lista de intereses de cada uno.

![alt text](https://lh3.googleusercontent.com/VFlglQwGHUHo5bpGpz41w-8yUdK3qcKtfjAd5A4k5BKKUlBF0mEcoyOLLXKMYwVk7o9VqeR5fh0FSA=w1440-h724-rw
 "Dashboard principal")


## Autor

* **Carlos A Torres** - *Dev principal* - [katorres02](https://github.com/katorres)
