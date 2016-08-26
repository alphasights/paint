module SCSSLint
  # Checks for units and enforce the use of rem() function to convert them.
  class Linter::PaintUnits < Linter
    include LinterRegistry

    FUNCTIONS_ALLOWING_UNITS_KEYWORD_ARGS = %w[
      map-get
      map-has-key
      map-remove
      rem
      em
      px
    ].to_set

    def visit_script_string(node)
      return unless node.type == :identifier

      remove_quoted_strings(node.value).scan(/(^\s|)([0-9]+)(px)(?=\s|;|$)/i) do |_, word|
        add_unit_lint(node, word)
      end
    end

  private

    def add_unit_lint(node, original)
      return if in_map?(node) || in_allowed_function_call?(node) || (original.to_i < 10)

      add_lint(node, "Use `rem(#{original})` or an existing `gutter($size)` value instead of `#{original}px`.")
    end

    def in_map?(node)
      node_ancestor(node, 2).is_a?(Sass::Script::Tree::MapLiteral)
    end

    def in_allowed_function_call?(node)
      if (funcall = node_ancestor(node, 2)).is_a?(Sass::Script::Tree::Funcall)
        FUNCTIONS_ALLOWING_UNITS_KEYWORD_ARGS.include?(funcall.name)
      end
    end
  end
end
