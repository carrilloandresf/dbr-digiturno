# Repositorio de Base de Datos para Aplicativo de Turnos Digitales

Este repositorio contiene scripts SQL para gestionar la base de datos de un aplicativo de turnos digitales. Los scripts se organizan en carpetas para facilitar el despliegue y el rollback de la base de datos en diferentes entornos.

## Estructura de Carpetas

- `scripts/`
  - `prod/`
    - `deploy/`
      - `1 - entidades.sql` (Crea la estructura de la base de datos y las tablas)
      - `2 - triggers.sql` (Define los disparadores y procedimientos almacenados)
      - `3 - data.sql` (Inserta datos iniciales)
    - `rollback/`
      - `1 - entidades.sql` (Elimina la base de datos completa)
  - `dev/` (Carpeta para scripts de desarrollo, si es necesario)
  - `qa/` (Carpeta para scripts de control de calidad, si es necesario)

## Tablas de la Base de Datos

### tbUsers

- **Descripción**: Esta tabla almacena información sobre los usuarios del aplicativo de notificaciones SMS, incluyendo sus datos de registro, nombres, direcciones, representantes legales, nombres de corporación y saldo de cuenta.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `username` (Nombre de usuario)
  - `password` (Contraseña)
  - `first_name` (Nombre)
  - `last_name` (Apellido)
  - `address` (Dirección)
  - `legal_representative_name` (Nombre del representante legal)
  - `corporation_name` (Nombre de la corporación)
  - `account_balance` (Saldo de la cuenta)

### tbAccessTokens

- **Descripción**: Esta tabla almacena tokens generados para cada usuario, incluyendo su fecha de registro y vigencia.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `token` (Token)
  - `validity` (Vigencia)
  - `user_id` (Clave foránea hacia tbUsers)

### tbDialingCodes

- **Descripción**: Esta tabla almacena códigos de marcación por país, junto con el nombre del país.
- **Campos**:
  - `id` (Clave primaria)
  - `dialing_code` (Código de marcación)
  - `country_name` (Nombre del país)

### tbCustomers

- **Descripción**: Esta tabla almacena información sobre los clientes del aplicativo, incluyendo su fecha de registro, nombres, números de celular, ciudad y código de marcación.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `first_name` (Nombre)
  - `last_name` (Apellido)
  - `phone_number` (Número de celular)
  - `city` (Ciudad)
  - `dialing_code_id` (Clave foránea hacia tbDialingCodes)

### tbTransactionTypes

- **Descripción**: Esta tabla almacena información sobre los tipos de transacción, incluyendo su fecha de registro, nombre del tipo, costo y precio.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `transaction_type` (Tipo de transacción)
  - `cost` (Costo)
  - `price` (Precio)
  - `user_id` (Clave foránea hacia tbUsers)

### tbUsersTransaction

- **Descripción**: Esta tabla almacena transacciones realizadas por usuarios, incluyendo la fecha de registro, cliente, usuario, tipo de transacción y mensaje de texto.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `customer_id` (Clave foránea hacia tbCustomers)
  - `user_id` (Clave foránea hacia tbUsers)
  - `transaction_type_id` (Clave foránea hacia tbTransactionTypes)
  - `message_text` (Mensaje de texto)

### tbAccountBalances

- **Descripción**: Esta tabla permite ver el balance de cada usuario, registrando la fecha de registro, usuario, tipo de movimiento (debe o haber) y valor de la transacción.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `user_id` (Clave foránea hacia tbUsers)
  - `movement_type` (Tipo de movimiento: debe o haber)
  - `transaction_value` (Valor de la transacción)

### tbUserCustomerRelation

- **Descripción**: Esta tabla se utiliza para establecer relaciones muchos a muchos entre usuarios y clientes. Registra la fecha de registro de cada relación.
- **Campos**:
  - `id` (Clave primaria)
  - `registration_date` (Fecha de registro)
  - `user_id` (Clave foránea hacia tbUsers)
  - `customer_id` (Clave foránea hacia tbCustomers)
  - `INDEX (id)`
  - `INDEX (user_id)`
  - `INDEX (customer_id)`
  - `INDEX (registration_date)`


## Instrucciones de Uso

### Despliegue de la Base de Datos

1. Clone este repositorio en su entorno de producción.

2. Acceda a su servidor MySQL y asegúrese de tener las credenciales necesarias.

3. Ejecute los scripts de despliegue en orden:

   ```shell
   mysql -u <usuario> -p < base_de_datos < scripts/prod/deploy/1\ -\ entidades.sql
   mysql -u <usuario> -p < base_de_datos < scripts/prod/deploy/2\ -\ triggers.sql
   mysql -u <usuario> -p < base_de_datos < scripts/prod/deploy/3\ -\ data.sql
   ```

Asegúrese de reemplazar <usuario> con su nombre de usuario de MySQL y <base_de_datos> con el nombre de la base de datos de destino.

La base de datos debería estar configurada y poblada con datos iniciales.

## Rollback de la Base de Datos
En caso de necesitar un rollback completo de la base de datos, puede utilizar el script en scripts/prod/rollback/1 - entidades.sql. Este script eliminará la base de datos completa si es necesario.

```shell
mysql -u <usuario> -p < base_de_datos < scripts/prod/rollback/1\ -\ entidades.sql
```

Asegúrese de reemplazar <usuario> con su nombre de usuario de MySQL y <base_de_datos> con el nombre de la base de datos de destino.

## Entornos Adicionales

Si necesita configurar entornos adicionales, como desarrollo (dev) o control de calidad (qa), puede crear carpetas adicionales dentro de la carpeta scripts y organizar los scripts correspondientes en esas carpetas.

Siempre recuerde mantener la seguridad de sus credenciales de base de datos y siga las mejores prácticas al realizar cambios en su base de datos en producción.

¡Gracias por utilizar este repositorio para administrar su base de datos de turnos digitales!

Recuerda personalizar las etiquetas `<usuario>` y `<base_de_datos>` con los valores específicos de tu configuración de MySQL. Además, puedes agregar más detalles y personalizar las instrucciones según las necesidades de tu proyecto y equipo.
