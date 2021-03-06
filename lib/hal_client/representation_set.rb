class HalClient

  # A collection HAL representations
  class RepresentationSet
    include Enumerable
    extend Forwardable

    def initialize(reprs)
      @reprs = reprs
    end

    def_delegators :reprs, :each, :count, :empty?, :any?

    # Returns representations of resources related via the specified
    #   link rel or the specified default value.
    #
    # name_or_rel - The name of property or link rel of interest
    # options - optional keys and values with which to expand any
    #   templated links that are encountered
    # default_proc - an option proc that will be called with `name`
    #  to produce default value if the specified property or link does not
    #  exist
    #
    # Raises KeyError if the specified link does not exist
    #   and no default_proc is provided.
    def related(link_rel, options={})
      RepresentationSet.new flat_map{|it| it.related(link_rel, options){[]}.to_a }
    end

    protected

    attr_reader :reprs
  end
end
