require 'smoothsort/smoothsort'

module Enumerable
  def ssort
    a = self.clone
    a.ssort!
    a
  end
end
