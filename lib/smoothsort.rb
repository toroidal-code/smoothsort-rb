require 'smoothsort/smoothsort'
require 'smoothsort/version'

module Enumerable
  def ssort
    a = self.clone
    a.ssort!
    a
  end
end
