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
Rollback de la Base de Datos
En caso de necesitar un rollback completo de la base de datos, puede utilizar el script en scripts/prod/rollback/1 - entidades.sql. Este script eliminará la base de datos completa si es necesario.

```shell
mysql -u <usuario> -p < base_de_datos < scripts/prod/rollback/1\ -\ entidades.sql
```

Asegúrese de reemplazar <usuario> con su nombre de usuario de MySQL y <base_de_datos> con el nombre de la base de datos de destino.

Entornos Adicionales

Si necesita configurar entornos adicionales, como desarrollo (dev) o control de calidad (qa), puede crear carpetas adicionales dentro de la carpeta scripts y organizar los scripts correspondientes en esas carpetas.

Siempre recuerde mantener la seguridad de sus credenciales de base de datos y siga las mejores prácticas al realizar cambios en su base de datos en producción.

¡Gracias por utilizar este repositorio para administrar su base de datos de turnos digitales!

Recuerda personalizar las etiquetas `<usuario>` y `<base_de_datos>` con los valores específicos de tu configuración de MySQL. Además, puedes agregar más detalles y personalizar las instrucciones según las necesidades de tu proyecto y equipo.
