# Demo Dependabot — paso a paso

## Objetivo

Enseñar que la supply chain también forma parte del SDLC agentic.

Frase central:

> CodeQL me ayuda con lo que escribo. Dependabot me ayuda con lo que importo.

## Antes de la sesión

El repo tiene dos fuentes fáciles de actualizar:

### NuGet
`Microsoft.Data.Sqlite` está fijado a `8.0.0`.

No digas que esa versión es vulnerable salvo que GitHub muestre un alert real.
La usamos para **Version Updates**.

### GitHub Actions
El workflow:

`.github/workflows/dependabot-demo.yml`

usa deliberadamente:

```yaml
actions/checkout@v3
actions/setup-dotnet@v3
```

El objetivo es que Dependabot tenga versiones antiguas visibles.

## Forzar comprobación antes de la sesión

Ve a:

```text
Insights
→ Dependency graph
→ Dependabot
```

Para cada ecosistema:

```text
NuGet
GitHub Actions
```

entra en el último job / Recent update jobs y pulsa:

```text
Check for updates
```

Espera a que Dependabot cree PRs.

## Qué debes dejar abierto

Un PR de Dependabot, preferiblemente el de GitHub Actions.

## Durante la sesión

Abre:

`.github/dependabot.yml`

Di:

> “Hasta ahora hemos hablado de nuestro código. Pero una aplicación también está formada por todo lo que importamos.”

Enseña:

```yaml
package-ecosystem: "nuget"
```

Di:

> “Dependabot revisa paquetes .NET.”

Enseña:

```yaml
package-ecosystem: "github-actions"
```

Di:

> “Y esto se olvida muchísimo: nuestros workflows también tienen dependencias.”

Después abre:

`.github/workflows/dependabot-demo.yml`

y enseña:

```yaml
uses: actions/checkout@v3
uses: actions/setup-dotnet@v3
```

Después abre el PR automático creado por Dependabot.

Di:

> “Yo no he escrito este Pull Request. Dependabot ha detectado una dependencia desactualizada y ha preparado el cambio.”

## Diferencia que debes explicar

```text
VERSION UPDATES
Hay una versión más reciente
→ Dependabot propone actualizar

SECURITY ALERT
GitHub conoce una vulnerabilidad en una dependencia
→ aparece un alert

SECURITY UPDATE
Existe versión corregida
→ Dependabot puede crear PR hacia la versión segura
```

No digas que `schedule.interval: daily` define la urgencia de un Security Alert.
Ese schedule es para Version Updates.

## Comparación final

```text
Copilot Review
→ lógica/contexto del PR

CodeQL
→ problemas en nuestro código

Dependabot
→ dependencias / supply chain

Secret scanning
→ credenciales y secretos
```
