# Terraform en tres niveles


## main.tf
Este código de **Terraform** establece la infraestructura en **AWS** para un entorno de tres niveles con **frontend**, **backend**, **balanceador** y **NFS**, cada uno con su propio **grupo de seguridad**, reglas de entrada/salida y una **instancia**.
### Configuración del proveedor AWS

    provider "aws" {
      region = var.region
    }

-   Se configura el proveedor AWS, especificando la región a través de la variable `var.region`.

### Configuración del Frontend

#### Creación del Grupo de Seguridad del Frontend

    resource "aws_security_group" "sg_frontend" {
      name        = var.nombre_sg_frontend
      description = var.descripcion_sg_frontend
    }

-   Se crea un **grupo de seguridad** para el **frontend** con nombre y descripción definidos por las variables.

#### Reglas de entrada del Grupo de Seguridad del Frontend

    resource "aws_security_group_rule" "sg_frontend" {
      security_group_id = aws_security_group.sg_frontend.id
      type              = "ingress"
      count             = length(var.puertos_frontend)
      from_port         = var.puertos_frontend[count.index]
      to_port           = var.puertos_frontend[count.index]
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
    }

-   Se crean **reglas de entrada** para el **grupo de seguridad** del **frontend**, permitiendo el tráfico en los **puertos** definidos por la variable `var.puertos_frontend`.

#### Reglas de salida del Grupo de Seguridad del Frontend

    resource "aws_security_group_rule" "sg_frontend_salida" {
      security_group_id = aws_security_group.sg_frontend.id
      type              = "egress"
      from_port         = 0
      to_port           = 0
      protocol          = "-1"
      cidr_blocks       = ["0.0.0.0/0"]
    }

-   Se crean **reglas** de salida para el **grupo de seguridad** del **frontend**, permitiendo todo el **tráfico de salida**.

#### Creación de una Instancia EC2 para el Frontend

    resource "aws_instance" "instancia_frontend" {
      ami             = var.id_ami
      instance_type   = var.tipo_instancia
      key_name        = var.nombre_clave
      security_groups = [aws_security_group.sg_frontend.name]
    
      tags = {
        Name = var.nombre_instancia_frontend
      }
    } 

-   Se crea una instancia para el **frontend**, utilizando la **AMI**, **tipo** de instancia, **clave** y **grupo de seguridad** definidos por las variables.

#### Creación de una IP Elástica y Asociación a la Instancia del Frontend

    resource "aws_eip" "ip_elastica_frontend" {
      instance = aws_instance.instancia_frontend.id
    } 

-   Se crea una **IP elástica** y se asocia a la **instancia** del **frontend**.

### Configuración del NFS, Backend y Balanceador
Funcionan igual que el **Frontend**, solo se diferencian en los nombres, puertos e IP elásticas.

## variables.tf
Estas **variables** permiten configurar de manera flexible aspectos específicos de la infraestructura, como la región, los puertos permitidos y los nombres de los grupos de seguridad, lo que facilita la adaptación del script a diferentes entornos y requisitos.
- **`region`:**  Permite personalizar la región AWS según los requisitos del entorno.
- **`puertos_frontend`:** Permite configurar los puertos a los que la instancia frontend puede recibir tráfico.
-  **`puertos_backend`:** Permite configurar los puertos a los que la instancia backend puede recibir tráfico.
-  **`puertos_nfs`:** Permite configurar los puertos a los que la instancia NFS puede recibir tráfico.
-  **`puertos_balanceador`:** Permite configurar los puertos a los que el balanceador de carga puede recibir tráfico.
-  **`nombre_sg_frontend`:** Personaliza el nombre del grupo de seguridad para la instancia frontend.
-  **`nombre_sg_backend`:** Personaliza el nombre del grupo de seguridad para la instancia backend.
-  **`nombre_sg_nfs`:** Personaliza el nombre del grupo de seguridad para la instancia NFS.

## output.tf
El bloque `output` en **Terraform** se utiliza para definir valores que se deben mostrar después de que se haya aplicado el código. En este caso, estás creando un `output` llamado *"elastic_ip"* que mostrará la dirección IP pública de la **Elastic IP** asociada a la **instancia**.
