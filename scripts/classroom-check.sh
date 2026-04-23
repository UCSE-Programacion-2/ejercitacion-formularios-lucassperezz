#!/usr/bin/env bash
# Verificaciones automáticas — Formularios DC Heroes (solo formularios.html).
set -u

HTML="formularios.html"
CSS="css/formularios.css"

fail() {
  echo "$1" >&2
  exit 1
}

ok() {
  echo CORRECTO
}

clean_css() {
  perl -0777 -pe 's@/\*.*?\*/@@gs' "$CSS"
}

clean_html() {
  perl -0777 -pe 's@<!--.*?-->@@gs' "$HTML"
}

case "${1:-}" in
  base-structure)
    [[ -f "$HTML" ]] || fail "No se encontró formularios.html en la raíz del proyecto."
    [[ -f "$CSS" ]] || fail "No se encontró css/formularios.css."
    [[ -d "img" ]] || fail "No se encontró la carpeta img/."
    img_count=$(find img -type f 2>/dev/null | wc -l | tr -d ' ')
    [[ "${img_count:-0}" -ge 1 ]] || fail "La carpeta img/ debe existir y contener al menos un archivo (exportalo desde Figma y subilo al repositorio)."
    ok
    ;;
  css-linked)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    [[ -f "$CSS" ]] || fail "No existe css/formularios.css."
    grep -qiE '<link[^>]+href=["'\'']css/formularios\.css["'\'']' "$HTML" \
      || fail "Falta enlazar css/formularios.css con <link rel=\"stylesheet\" href=\"css/formularios.css\" /> (o equivalente con comillas simples)."
    ok
    ;;
  chrome-semantico)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    grep -qi '<header' "$HTML" || fail "Falta una etiqueta <header> en formularios.html."
    grep -qi '<nav' "$HTML" || fail "Falta una etiqueta <nav> en formularios.html."
    grep -qi '<main' "$HTML" || fail "Falta una etiqueta <main> en formularios.html."
    grep -qi '<footer' "$HTML" || fail "Falta una etiqueta <footer> en formularios.html."
    ok
    ;;
  form-basico)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    body="$(clean_html)"
    grep -qi '<form' <<<"$body" || fail "Falta un <form> que agrupe los campos."
    grep -qiE 'method=["'\'']post["'\'']' <<<"$body" || fail "El <form> debe enviarse con method=\"post\"."
    grep -qiE '<button[^>]+type=["'\'']submit["'\'']' <<<"$body" \
      || fail "Falta un <button type=\"submit\"> para enviar el formulario."
    grep -qi 'Añadir' <<<"$body" || fail "El botón de envío debe mostrar el texto «Añadir», como en Figma."
    ok
    ;;
  campos-requeridos)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    body="$(clean_html)"
    grep -qiE '<input[^>]*id=["'\'']nombre["'\''][^>]*required' <<<"$body" \
      || grep -qiE '<input[^>]*required[^>]*id=["'\'']nombre["'\'']' <<<"$body" \
      || fail "El campo nombre debe ser obligatorio: <input id=\"nombre\" ... required />."
    grep -qiE '<select[^>]*id=["'\'']especie["'\''][^>]*required' <<<"$body" \
      || grep -qiE '<select[^>]*required[^>]*id=["'\'']especie["'\'']' <<<"$body" \
      || fail "El selector de especie debe ser obligatorio: <select id=\"especie\" ... required>."
    ok
    ;;
  tipos-html5)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    body="$(clean_html)"
    grep -qiE 'type=["'\'']date["'\'']' <<<"$body" || fail "Falta un control <input type=\"date\"> para la fecha de aparición."
    grep -qiE 'type=["'\'']file["'\'']' <<<"$body" || fail "Falta un <input type=\"file\"> para adjuntar la foto."
    grep -qi '<textarea' <<<"$body" || fail "Falta un <textarea> para la descripción del personaje."
    ok
    ;;
  poderes-fieldset)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    body="$(clean_html)"
    grep -qi '<fieldset' <<<"$body" || fail "Usá <fieldset> para agrupar los poderes (mejor práctica de formularios)."
    grep -qi '<legend' <<<"$body" || fail "Cada <fieldset> debe incluir un <legend> descriptivo."
    grep -qi '<legend>Poderes' <<<"$body" || fail "El bloque de poderes debe usar <legend>Poderes</legend>."
    checks=$(grep -oi 'type=["'\'']checkbox["'\'']' <<<"$body" | wc -l | tr -d ' ')
    [[ "${checks:-0}" -ge 4 ]] || fail "Se esperaban al menos 4 checkboxes de poderes. Encontrados: ${checks:-0}."
    ok
    ;;
  tipo-radio)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    body="$(clean_html)"
    radios=$(grep -oi 'type=["'\'']radio["'\'']' <<<"$body" | wc -l | tr -d ' ')
    [[ "${radios:-0}" -ge 2 ]] || fail "Se esperaban al menos dos botones de opción (radio) para el tipo de personaje."
    grep -qiE 'name=["'\'']tipo-personaje["'\'']' <<<"$body" \
      || fail "Los radios de tipo de personaje deben compartir name=\"tipo-personaje\"."
    ok
    ;;
  textos-consigna)
    [[ -f "$HTML" ]] || fail "No existe formularios.html."
    body="$(clean_html)"
    grep -qi 'Añadí tu super' <<<"$body" || fail "Falta el titular «Añadí tu super!» del encabezado del formulario."
    grep -qi 'Agregá tu personaje favorito' <<<"$body" \
      || fail "Falta el texto guía «Agregá tu personaje favorito completando las opciones.»."
    ok
    ;;
  css-formulario)
    [[ -f "$CSS" ]] || fail "No existe css/formularios.css."
    clean_content="$(clean_css)"
    grep -qiE '(^|[^-[:alnum:]_])display[[:space:]]*:' <<< "$clean_content" \
      || fail "Usá display (flex o grid) para organizar columnas del formulario, como en la maqueta."
    grep -qiE '(^|[^-[:alnum:]_])border-radius[[:space:]]*:' <<< "$clean_content" \
      || fail "La maqueta usa esquinas redondeadas: declará border-radius en tus reglas."
    grep -qiE '(^|[^-[:alnum:]_])(padding|gap)[[:space:]]*:' <<< "$clean_content" \
      || fail "Incluí padding o gap en el CSS para separar campos y secciones."
    ok
    ;;
  *)
    echo "Prueba automática no reconocida. Avísale al docente." >&2
    exit 2
    ;;
esac
