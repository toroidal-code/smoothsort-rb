require 'smoothsort/smoothsort'
require 'smoothsort/version'

module Enumerable
  # Returns an array containing the items in enum sorted, according to their own <=> method,
  # using the smoothsort algorithm
  #
  # @return [Array] The sorted array
  def ssort
    a = self.clone
    a.ssort!
    a
  end
end
