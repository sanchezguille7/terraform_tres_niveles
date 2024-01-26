# Configuramos el proveedor de AWS
provider "aws" {
  region = var.region
}

# frontend
# Creamos el grupo de seguridad
resource "aws_security_group" "sg_frontend" {
  name        = var.nombre_sg_frontend
  description = var.descripcion_sg_frontend
}

# Creamos las reglas de entrada del grupo de seguridad. 
# Utilizamos un bucle para recorrer la lista de puertos definida como variable
resource "aws_security_group_rule" "sg_frontend" {
  security_group_id = aws_security_group.sg_frontend.id
  type              = "ingress"

  count       = length(var.puertos_frontend)
  from_port   = var.puertos_frontend[count.index]
  to_port     = var.puertos_frontend[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad.
resource "aws_security_group_rule" "sg_frontend_salida" {
  security_group_id = aws_security_group.sg_frontend.id
  type              = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos una instancia EC2
resource "aws_instance" "instancia_frontend" {
  ami             = var.id_ami
  instance_type   = var.tipo_instancia
  key_name        = var.nombre_clave
  security_groups = [aws_security_group.sg_frontend.name]

  tags = {
    Name = var.nombre_instancia_frontend
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica_frontend" {
  instance = aws_instance.instancia_frontend.id
}





# backend
# Creamos el grupo de seguridad
resource "aws_security_group" "sg_backend" {
  name        = var.nombre_sg_backend
  description = var.descripcion_sg_backend
}

# Creamos las reglas de entrada del grupo de seguridad. 
# Utilizamos un bucle para recorrer la lista de puertos definida como variable
resource "aws_security_group_rule" "sg_backend" {
  security_group_id = aws_security_group.sg_backend.id
  type              = "ingress"

  count       = length(var.puertos_backend)
  from_port   = var.puertos_backend[count.index]
  to_port     = var.puertos_backend[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad.
resource "aws_security_group_rule" "sg_backend_salida" {
  security_group_id = aws_security_group.sg_backend.id
  type              = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos una instancia EC2
resource "aws_instance" "instancia_backend" {
  ami             = var.id_ami
  instance_type   = var.tipo_instancia
  key_name        = var.nombre_clave
  security_groups = [aws_security_group.sg_backend.name]

  tags = {
    Name = var.nombre_instancia_backend
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica_backend" {
  instance = aws_instance.instancia_backend.id
}





# balanceador
# Creamos el grupo de seguridad
resource "aws_security_group" "sg_balanceador" {
  name        = var.nombre_sg_balanceador
  description = var.descripcion_sg_balanceador
}

# Creamos las reglas de entrada del grupo de seguridad. 
# Utilizamos un bucle para recorrer la lista de puertos definida como variable
resource "aws_security_group_rule" "sg_balanceador" {
  security_group_id = aws_security_group.sg_balanceador.id
  type              = "ingress"

  count       = length(var.puertos_balanceador)
  from_port   = var.puertos_balanceador[count.index]
  to_port     = var.puertos_balanceador[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad.
resource "aws_security_group_rule" "sg_balanceador_salida" {
  security_group_id = aws_security_group.sg_balanceador.id
  type              = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos una instancia EC2
resource "aws_instance" "instancia_balanceador" {
  ami             = var.id_ami
  instance_type   = var.tipo_instancia
  key_name        = var.nombre_clave
  security_groups = [aws_security_group.sg_balanceador.name]

  tags = {
    Name = var.nombre_instancia_balanceador
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica_balanceador" {
  instance = aws_instance.instancia_balanceador.id
}





#nfs
# Creamos el grupo de seguridad
resource "aws_security_group" "sg_nfs" {
  name        = var.nombre_sg_nfs
  description = var.descripcion_sg_nfs
}

# Creamos las reglas de entrada del grupo de seguridad. 
# Utilizamos un bucle para recorrer la lista de puertos definida como variable
resource "aws_security_group_rule" "sg_nfs" {
  security_group_id = aws_security_group.sg_nfs.id
  type              = "ingress"

  count       = length(var.puertos_nfs)
  from_port   = var.puertos_nfs[count.index]
  to_port     = var.puertos_nfs[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad.
resource "aws_security_group_rule" "sg_nfs_salida" {
  security_group_id = aws_security_group.sg_nfs.id
  type              = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos una instancia EC2
resource "aws_instance" "instancia_nfs" {
  ami             = var.id_ami
  instance_type   = var.tipo_instancia
  key_name        = var.nombre_clave
  security_groups = [aws_security_group.sg_nfs.name]

  tags = {
    Name = var.nombre_instancia_nfs
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica_nfs" {
  instance = aws_instance.instancia_nfs.id
}