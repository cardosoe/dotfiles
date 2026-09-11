#!/bin/zsh

# Variables
MOUNT_DIR=~/Documentos/CloudDrive/onedrive
REMOTE_NAME="onedrive"
LOG_FILE=~/rclone_mount.log

# Verifica si rclone está instalado
if ! command -v rclone &>/dev/null; then
  echo "❌ Error: rclone no está instalado. Por favor instálalo primero."
  exit 1
fi

# Crea el directorio de montaje si no existe
if [ ! -d "$MOUNT_DIR" ]; then
  echo "📁 Creando el directorio de montaje en $MOUNT_DIR..."
  mkdir -p "$MOUNT_DIR"
fi

# Verifica si ya está montado
if mount | grep -q "$MOUNT_DIR"; then
  echo "⚠️ Ya está montado en $MOUNT_DIR. No se hace nada."
  exit 0
fi

# Monta el remoto
echo "🔗 Montando $REMOTE_NAME en $MOUNT_DIR..."
rclone mount "$REMOTE_NAME:" "$MOUNT_DIR" \
  --vfs-cache-mode writes \
  --log-file="$LOG_FILE" \
  --log-level INFO &

echo "✅ Montaje iniciado. Logs disponibles en: $LOG_FILE"
