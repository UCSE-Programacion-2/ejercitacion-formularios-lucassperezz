[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/AX3_sspW)
# Ejercitación: Formularios HTML + CSS (continuidad DC Heroes)

Actividad pensada como **segunda entrega** después de `Ejercitacion-Box-Model`. Reutiliza la misma línea gráfica (barra de descuentos, cabecera «DC Heroes», navegación y pie) y suma un **formulario de alta de personaje** según el archivo de Figma.

## Diseño de referencia (obligatorio)

Maqueta oficial en Figma (Programación II):

[Formularios — DC Heroes](https://www.figma.com/design/XkPK9uYRorjlzutXPFSQkk/Formularios?node-id=0-1&t=UALzeYNQlm6AmYMp-1)

Frames clave:

- `Home`: pantalla previa con el botón flotante **«+»** que enlaza el flujo hacia el formulario.
- `Añadir`: pantalla evaluada con el panel azul, campos, poderes, radios y botón **Añadir**.

## ¿Qué se corrige automáticamente?

| Archivo / carpeta | Rol |
| --- | --- |
| `index.html` + `css/hub.css` | Pantalla **Home** con el FAB **+** hacia `formularios.html`. Sirve como continuidad visual y **no** tiene tests en GitHub Classroom. |
| `formularios.html` + `css/formularios.css` + `img/` | Único bloque que evalúan los scripts (`scripts/classroom-check.sh`). |

> Importante: **no** modifiques el repositorio de Box Model para esta actividad. Trabajá siempre en la copia nueva que te genera GitHub Classroom a partir de esta plantilla.

## Objetivos de aprendizaje

- Construir formularios accesibles (`label`, `fieldset`, textos equivalentes a la maqueta).
- Usar controles HTML5 (`date`, `file`, `textarea`, `select`, `checkbox`, `radio`).
- Aplicar `method="post"` y un botón `type="submit"`.
- Traducir el layout de Figma con **Flexbox**, `border-radius`, `padding` / `gap`.

## Ticket-driven development

1. Cuando **aceptás el assignment**, GitHub Classroom genera tu repositorio y suele ejecutar ya los workflows (incluido `Setup assignment issues`). Revisá la pestaña **Issues**: deberían aparecer las tarjetas guía sin que tengas que hacer nada especial. Si no las ves, esperá unos minutos o comprobá la pestaña **Actions**; cualquier `push` posterior a `main`/`master` también puede disparar el workflow, pero **no crea duplicados** (es idempotente por título).
2. Resolvé cada issue en orden lógico (HTML → estilos → detalles visuales).
3. Verificá localmente con:

```bash
bash scripts/classroom-check.sh base-structure
```

Repetí el comando cambiando el subcomando por cada prueba listada en `classroom.yml`.

## Recursos gráficos (los preparás vos)

1. Creá en la raíz del proyecto la carpeta **`img/`** (no viene en la plantilla).
2. Abrí el archivo de **Figma** enlazado arriba, seleccioná los íconos / ilustraciones del frame **Añadir** (y el de la Home si lo usás) y **exportalos** en PNG o SVG (resolución adecuada para web).
3. Guardá los archivos dentro de `img/` y referenciálos desde `index.html` y `formularios.html` con rutas relativas, por ejemplo `src="img/github-mark.png"`. Los nombres son libres mientras coincidan con lo que declares en el HTML; el autograding sólo exige que la carpeta exista y tenga **al menos un archivo**.

## Requisitos sólo revisables por el docente

- Fidelidad visual frente al frame **Añadir** (espaciados, jerarquía tipográfica, estados `:focus`).
- Reemplazo de `[TU NOMBRE Y APELLIDO]` en ambas pantallas.
- Coherencia de la navegación real (`href` de Contacto / Registrarme / Ingresar) si el docente lo pide explícitamente.

Los tests automáticos **no reemplazan** la revisión humana.

## Estructura del repositorio

```
Ejercitacion-Formularios/
├── index.html              # Home + botón «+»
├── formularios.html        # Formulario (autograding)
├── css/
│   ├── hub.css             # Estilos de la Home
│   └── formularios.css     # Estilos del formulario
├── img/                    # La creás vos y exportás desde Figma
├── scripts/
│   └── classroom-check.sh  # Pruebas locales / Classroom
└── .github/workflows/
    ├── classroom.yml       # Autograding oficial
    ├── setup-issues.yml    # Issues guía (idempotente)
    └── ci.yml              # Mismo script en cada push/PR
```

## Estado inicial

La plantilla llega con **tests en rojo** a propósito: debés **crear `img/` y cargar los gráficos exportados desde Figma**, reemplazar el párrafo placeholder de `formularios.html` por el markup completo (incluido el logo del pie si lo pedís en la maqueta) y completar `css/formularios.css` hasta que todas las verificaciones devuelvan `CORRECTO`.

## Licencia y créditos

Diseño de referencia: curso Programación II — UCSE. Ajustes técnicos y automatización: plantilla para GitHub Classroom.
