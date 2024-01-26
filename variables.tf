variable "region" {
  description = "Región AWS de la instancia"
  type        = string
  default     = "us-east-1"
}

variable "puertos_frontend" {
  description = "Puertos de entrada para Frontend"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "puertos_backend" {
  description = "Puertos de entrada para Backend"
  type        = list(number)
  default     = [22, 3306]
}

variable "puertos_nfs" {
  description = "Puertos de entrada para NFS"
  type        = list(number)
  default     = [22, 2049]
}

variable "puertos_balanceador" {
  description = "Puertos de entrada para balanceador de carga"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "nombre_sg_frontend" {
  description = "Nombre del grupo de seguridad para el Frontend"
  type        = string
  default     = "sg_frontend"
}

variable "nombre_sg_backend" {
  description = "Nombre del grupo de seguridad para el Backend"
  type        = string
  default     = "sg_backend"
}

variable "nombre_sg_nfs" {
  description = "Nombre del grupo de seguridad para el NFS"
  type        = string
  default     = "sg_nfs"
}

variable "nombre_sg_balanceador" {
  description = "Nombre del grupo de seguridad para el balanceador de carga"
  type        = string
  default     = "sg_balanceador_de_carga"
}

variable "descripcion_sg_frontend" {
  description = "Descripción del grupo de seguridad para la instancia del Frontend"
  type        = string
  default     = "Grupo de seguridad para la instancia del Frontend"
}

variable "descripcion_sg_backend" {
  description = "Descripción del grupo de seguridad para la instancia del Backend"
  type        = string
  default     = "Grupo de seguridad para la instancia del Backend"
}

variable "descripcion_sg_nfs" {
  description = "Descripción del grupo de seguridad para la instancia del nfs"
  type        = string
  default     = "Grupo de seguridad para la instancia del nfs"
}

variable "descripcion_sg_balanceador" {
  description = "Descripción del grupo de seguridad para la instancia del balanceador de carga"
  type        = string
  default     = "Grupo de seguridad para la instancia del balanceador de carga"
}

variable "id_ami" {
  description = "Identificador de la AMI de Ubuntu 22.04"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.small"
}

variable "nombre_clave" {
  description = "Nombre de la clave pública"
  type        = string
  default     = "examen"
}

variable "nombre_instancia_frontend" {
  description = "Nombre de la instancia para el Frontend"
  type        = string
  default     = "frontend"
}

variable "nombre_instancia_backend" {
  description = "Nombre de la instancia para el Backend"
  type        = string
  default     = "backend"
}

variable "nombre_instancia_nfs" {
  description = "Nombre de la instancia para el nfs"
  type        = string
  default     = "nfs"
}

variable "nombre_instancia_balanceador" {
  description = "Nombre de la instancia para el balanceador de carga"
  type        = string
  default     = "balanceador_de_carga"
}