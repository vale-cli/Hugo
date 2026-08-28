# Hugo

A Vale configuration for [Hugo](https://gohugo.io/)-generated static sites.

This package configures Vale to ignore [Hugo shortcodes](https://gohugo.io/content-management/shortcodes/)
in Markdown files, so that their names and arguments aren't flagged by
prose-oriented rules while the surrounding content is still checked.

## Installation

Add the package to your `.vale.ini`:

```ini
StylesPath = styles

Packages = Hugo

[*.md]
BasedOnStyles = Vale
```

Then run `vale sync`.

## What's ignored

The configuration handles the following shortcode forms, in both `{{< ... >}}`
and `{{% ... %}}` notation:

```markdown
{{< toc >}}

{{< youtube id="w7Ft2ymGmfc" autoplay="true" >}}

{{< instagram BWNjjyYFxVx hidecaption >}}

{{< styled-img src="image.webp" alt="A hyphenated shortcode name" >}}

{{< gallery/image src="A shortcode in a nested directory" >}}

{{< /tabs >}}

{{% unsplash
  name="A multiline shortcode"
  href="with or without trailing whitespace"
%}}

{{< myshortcode This is some <b>HTML</b>,
and a new line with a "quoted string". >}}

{{< highlight html >}}
<h1 id="title">{{ .Title }}</h1>
{{< /highlight >}}
```

Shortcodes are also ignored inline — mid-paragraph, at the start of a line
with trailing text, in list items, and as link destinations
(`[Contact us]({{< relref "contact.md" >}})`) — as well as escaped
shortcodes using Hugo's comment syntax (`{{</* ... */>}}`).

## What's still checked

Regular prose is always linted, including:

- content between a paired shortcode's opening and closing tags, and
- text between two shortcodes on the same line.

## Testing

```console
$ make test
```

The tests build `Hugo.zip`, sync it into `testdata/`, and compare Vale's
output on `testdata/shortcodes.md` against the golden file `testdata/test.ct`
(regenerate it with `go test ./... -update`).
