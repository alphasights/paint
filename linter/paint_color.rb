module SCSSLint
  # Checks for uses of a color keyword instead of the preferred hexadecimal
  # form.
  class Linter::PaintColor < Linter
    include LinterRegistry

    FUNCTIONS_ALLOWING_COLOR_KEYWORD_ARGS = %w[
      map-get
      map-has-key
      map-remove
      color
    ].to_set

    def visit_script_string(node)
      return unless node.type == :identifier

      remove_quoted_strings(node.value).scan(/(^|\s)(^(#[a-f0-9]{3,6}|[a-z]+))(?=\s|$)/i) do |_, word|
        add_color_lint(node, word) if color?(word)
      end
    end

  private

    def add_color_lint(node, original)
      return if in_map?(node) || in_allowed_function_call?(node)

      add_lint(node, "Use `color(#{original})` or an existing palette value.")
    end

    def in_map?(node)
      node_ancestor(node, 2).is_a?(Sass::Script::Tree::MapLiteral)
    end

    def in_allowed_function_call?(node)
      if (funcall = node_ancestor(node, 2)).is_a?(Sass::Script::Tree::Funcall)
        FUNCTIONS_ALLOWING_COLOR_KEYWORD_ARGS.include?(funcall.name)
      end
    end
  end
end
