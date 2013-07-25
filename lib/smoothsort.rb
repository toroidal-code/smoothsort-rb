require 'smoothsort/smoothsort'
require 'smoothsort/version'

module Enumerable
  # Returns an array containing the items in enum sorted, according to their own <=> method
  #
  # @return [array] The sorted array
  def ssort
    a = self.clone
    a.ssort!
    a
  end
end
