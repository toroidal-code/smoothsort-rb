require 'smoothsort/version'

module Enumerable
  # Sorts an array in-place, using the smoothsort algorithm
  #
  # @return [Array] The sorted array
  def ssort!
    len = self.length
    q   = 1
    idx = 0
    p   = 1
    b   = 1
    c   = 1
    # build the tree
    while q < len
      idx1 = idx
      if (p & 7) == 3
        b1   = b
        c1   = c
        idx0 = idx1
        t    = self[idx0]
        while b1 >= 3
          idx2 = idx1 - b1 + c1
          unless self[idx1 - 1] <= self[idx2]
            idx2   = idx1 - 1
            b1, c1 = c1, b1 - c1 - 1
          end
          if self[idx2] <= t
            b1 = 1
          else
            self[idx1] = self[idx2]
            idx1       = idx2
            b1, c1     = c1, b1 - c1 - 1
          end
        end
        if idx1 != idx0
          self[idx1] = t
        end
        p    = (p + 1) >> 2
        b, c = b + c + 1, b
        b, c = b + c + 1, b
      elsif (p & 3) == 1
        if (q + c) < len
          b1   = b
          c1   = c
          idx0 = idx1
          t    = self[idx0]
          while b1 >= 3
            idx2 = idx1 - b1 + c1
            unless self[idx1 - 1] <= self[idx2]
              idx2   = idx1 - 1
              b1, c1 = c1, b1 - c1 - 1
            end
            if self[idx2] <= t
              b1 = 1
            else
              self[idx1] = self[idx2]
              idx1       = idx2
              b1, c1     = c1, b1 - c1 - 1
            end
          end
          if idx1 != idx0
            self[idx1] = t
          end
        else
          p1   = p
          b1   = b
          c1   = c
          idx0 = idx1
          t    = self[idx0]
          while p1 > 0
            while (p1 & 1) == 0
              p1     >>= 1
              b1, c1 = b1 + c1 + 1, b1
            end
            r3 = idx1 - b1
            if p1 == 1 or self[r3] <= t
              p1 = 0
            else
              p1 -= 1
              if b1 == 1
                self[idx1] = self[r3]
                idx1       = r3
              elsif b1 >= 3
                idx2 = idx1 - b1 + c1
                unless self[idx1 - 1] <= self[idx2]
                  idx2   = idx1 - 1
                  b1, c1 = c1, b1 - c1 - 1
                  p1     <<= 1
                end
                if self[idx2] <= self[r3]
                  self[idx1] = self[r3]
                  idx1       = r3
                else
                  self[idx1] = self[idx2]
                  idx1       = idx2
                  b1, c1     = c1, b1 - c1 - 1
                  p1         = 0
                end
              end
            end
          end
          if idx0 != idx1
            self[idx1] = t
          end
          idx0 = idx1
          t    = self[idx0]
          while b1 >= 3
            idx2 = idx1 - b1 + c1
            unless self[idx1 - 1] <= self[idx2]
              idx2   = idx1 - 1
              b1, c1 = c1, b1 - c1 - 1
            end
            if self[idx2] <= t
              b1 = 1
            else
              self[idx1] = self[idx2]
              idx1       = idx2
              b1, c1     = c1, b1 - c1 - 1
            end
          end
          if idx1 != idx0
            self[idx1] = t
          end
        end
        b, c = c, b - c - 1
        p    <<= 1
        while b > 1
          b, c = c, b - c - 1
          p    <<= 1
        end
        p += 1
      end
      q   += 1
      idx += 1
    end

    idx1 = idx
    p1   = p
    b1   = b
    c1   = c
    idx0 = idx1
    t    = self[idx0]
    while p1 > 0
      while (p1 & 1) == 0
        p1     >>= 1
        b1, c1 = b1 + c1 + 1, b1
      end
      r3 = idx1 - b1
      if p1 == 1 or self[r3] <= t
        p1 = 0
      else
        p1 -= 1
        if b1 == 1
          self[idx1] = self[r3]
          idx1       = r3
        elsif b1 >= 3
          idx2 = idx1 - b1 + c1
          unless self[idx1 - 1] <= self[idx2]
            idx2   = idx1 - 1
            b1, c1 = c1, b1 - c1 - 1
            p1     <<= 1
          end
          if self[idx2] <= self[r3]
            self[idx1] = self[r3]
            idx1       = r3
          else
            self[idx1] = self[idx2]
            idx1       = idx2
            b1, c1     = c1, b1 - c1 - 1
            p1         = 0
          end
        end
      end
    end
    if idx0 != idx1
      self[idx1] = t
    end
    idx0 = idx1
    t    = self[idx0]
    while b1 >= 3
      idx2 = idx1 - b1 + c1
      unless self[idx1 - 1] <= self[idx2]
        idx2   = idx1 - 1
        b1, c1 = c1, b1 - c1 - 1
      end
      if self[idx2] <= t
        b1 = 1
      else
        self[idx1] = self[idx2]
        idx1       = idx2
        b1, c1     = c1, b1 - c1 - 1
      end
    end
    if idx1 != idx0
      self[idx1] = t
    end

    #build the sorted array
    while q > 1
      q -= 1
      if b == 1
        idx -= 1
        p   -= 1
        while (p & 1) == 0
          p    >>= 1
          b, c = b + c + 1, b
        end
      elsif b >= 3
        p   -= 1
        idx = idx - b + c
        if p > 0
          idx1 = idx - c
          unless self[idx1] <= self[idx]
            self[idx], self[idx1] = self[idx1], self[idx]
            p1                    = p
            b1                    = b
            c1                    = c
            idx0                  = idx1
            t                     = self[idx0]
            while p1 > 0
              while (p1 & 1) == 0
                p1     >>= 1
                b1, c1 = b1 + c1 + 1, b1
              end
              r3 = idx1 - b1
              if p1 == 1 or self[r3] <= t
                p1 = 0
              else
                p1 -= 1
                if b1 == 1
                  self[idx1] = self[r3]
                  idx1       = r3
                elsif b1 >= 3
                  idx2 = idx1 - b1 + c1
                  unless self[idx1 - 1] <= self[idx2]
                    idx2   = idx1 - 1
                    b1, c1 = c1, b1 - c1 - 1
                    p1     <<= 1
                  end
                  if self[idx2] <= self[r3]
                    self[idx1] = self[r3]
                    idx1       = r3
                  else
                    self[idx1] = self[idx2]
                    idx1       = idx2
                    b1, c1     = c1, b1 - c1 - 1
                    p1         = 0
                  end
                end
              end
            end
            if idx0 != idx1
              self[idx1] = t
            end
            idx0 = idx1
            t    = self[idx0]
            while b1 >= 3
              idx2 = idx1 - b1 + c1
              unless self[idx1 - 1] <= self[idx2]
                idx2   = idx1 - 1
                b1, c1 = c1, b1 - c1 - 1
              end
              if self[idx2] <= t
                b1 = 1
              else
                self[idx1] = self[idx2]
                idx1       = idx2
                b1, c1     = c1, b1 - c1 - 1
              end
            end
            if idx1 != idx0
              self[idx1] = t
            end
          end
        end
        b, c = c, b - c - 1
        p    = (p << 1) + 1
        idx  += c
        idx1 = idx - c
        unless self[idx1] <= self[idx]
          self[idx], self[idx1] = self[idx1], self[idx]
          p1                    = p
          b1                    = b
          c1                    = c
          idx0                  = idx1
          t                     = self[idx0]
          while p1 > 0
            while (p1 & 1) == 0
              p1     >>= 1
              b1, c1 = b1 + c1 + 1, b1
            end
            r3 = idx1 - b1
            if p1 == 1 or self[r3] <= t
              p1 = 0
            else
              p1 -= 1
              if b1 == 1
                self[idx1] = self[r3]
                idx1       = r3
              elsif b1 >= 3
                idx2 = idx1 - b1 + c1
                unless self[idx1 - 1] <= self[idx2]
                  idx2   = idx1 - 1
                  b1, c1 = c1, b1 - c1 - 1
                  p1     <<= 1
                end
                if self[idx2] <= self[r3]
                  self[idx1] = self[r3]
                  idx1       = r3
                else
                  self[idx1] = self[idx2]
                  idx1       = idx2
                  b1, c1     = c1, b1 - c1 - 1
                  p1         = 0
                end
              end
            end
          end
          if idx0 != idx1
            self[idx1] = t
          end
          idx0 = idx1
          t    = self[idx0]
          while b1 >= 3
            idx2 = idx1 - b1 + c1
            unless self[idx1 - 1] <= self[idx2]
              idx2   = idx1 - 1
              b1, c1 = c1, b1 - c1 - 1
            end
            if self[idx2] <= t
              b1 = 1
            else
              self[idx1] = self[idx2]
              idx1       = idx2
              b1, c1     = c1, b1 - c1 - 1
            end
          end
          if idx1 != idx0
            self[idx1] = t
          end
        end
        b, c = c, b - c - 1
        p    = (p << 1) + 1
        # element q is done
        # element 0 is done
      end
    end
    self
  end


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



