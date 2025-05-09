module Jekyll
  module Tags
    ##
    # This class adds a tag that checks if a file exists.
    class FileExistsTag < Liquid::Tag
      def initialize(tag_name, path, tokens) # :nodoc:
        super
        @path = path
      end

      ##
      # file_exists - Check if a file exists and return an appropriate boolean
      #
      # Examples:
      #
      #   {% capture hasfaq %}{% file_exists {{faqpage}} %}{% endcapture %}
      def render(context)
        # Pipe parameter through Liquid to make additional replacements possible
        url = Liquid::Template.parse(@path).render context

        # Adds the site source, so that it also works with a custom one
        site_source = context.registers[:site].config['source']
        file_path = "#{site_source}/#{url}"

        # Check if file exists (returns true or false)
        File.exist?(file_path.strip!).to_s
      end
    end
  end
end

Liquid::Template.register_tag('file_exists', Jekyll::Tags::FileExistsTag)
