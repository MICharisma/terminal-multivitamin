#!/usr/bin/env zsh
# Navigation and files · 07 · Montevideo school office sorting parents' attachments
#
# Teaches:
#   - `file -b --mime-type` reads a file's contents, not its (often wrong) extension
#   - a `case` statement routes each MIME type to a folder
#   - `mkdir -p` inside the loop creates a destination only when it is needed
#   - `mv --` moves into a folder, keeping the original name
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/escuela-142-inbox.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir bandeja
# Parents' phones name files however they like; the bytes tell the truth.
printf '%%PDF-1.4\n1 0 obj\n<< /Type /Catalog >>\nendobj\ntrailer\n<< /Root 1 0 R >>\n%%%%EOF\n' > bandeja/permiso-paseo-colonia_rodriguez.jpg
printf '%%PDF-1.4\n1 0 obj\n<< /Type /Catalog >>\nendobj\ntrailer\n<< /Root 1 0 R >>\n%%%%EOF\n' > bandeja/autorizacion_silva.pdf
printf '\x89PNG\r\n\x1a\n\0\0\0\rIHDR\0\0\0\x01\0\0\0\x01\x08\x02\0\0\0\x90wS\xde' > bandeja/foto-carne_martina.pdf
printf '\x89PNG\r\n\x1a\n\0\0\0\rIHDR\0\0\0\x01\0\0\0\x01\x08\x02\0\0\0\x90wS\xde' > bandeja/imagen-whatsapp-2026-11-20
print "Valentina falta el viernes por consulta médica. — Mamá de Valentina" > bandeja/nota.doc

# region: read-mime
# focus: file -b --mime-type -- $attachment
for attachment in bandeja/*; do
  mime=$(file -b --mime-type -- $attachment)
  # endregion: read-mime
  # region: route-by-type
  # focus: case $mime in
  case $mime in
    (application/pdf) folder=permisos ;;
    (image/*)         folder=fotos ;;
    (text/plain)      folder=notas ;;
    (*)               folder=revisar ;;
  esac
  # endregion: route-by-type
  # region: move-into-folder
  # focus: mv -- $attachment $folder/
  mkdir -p $folder
  mv -- $attachment $folder/
  print "${attachment:t} ($mime) -> $folder/"
  # endregion: move-into-folder
done

# region: check-folders
# focus: ls -F
print "== office folders:"
ls -F
print "== bandeja is empty: $([[ -z $(ls -A bandeja) ]] && print yes || print no)"
# endregion: check-folders
