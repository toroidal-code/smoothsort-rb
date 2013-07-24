module Enumerable

  class SSort
    attr_accessor :q, :r, :p, :b, :c, :r1, :b1, :c1, :N, :a
    private

    def self.asc?(vb, vc)
      vb <= vc
    end

    def self.up(vb, vc)
      [vb + vc + 1, vb]
    end

    def self.down(vb, vc)
      [vc, vb - vc - 1]
    end

    def self.sift
      r0 = @r1
      t  = @a[r0]
      while @b1 >= 3
        r2 = @r1 - @b1 + @c1
        if !asc?(@a[@r1 - 1], @a[r2])
          r2       = @r1 - 1
          @b1, @c1 = down(@b1, @c1)
        end
        if asc?(@a[r2], t)
          @b1 = 1
        else
          @a[@r1]  = @a[r2]
          @r1      = r2
          @b1, @c1 = down(@b1, @c1)
        end
      end
      if @r1 != r0
        @a[@r1] = t
      end
    end

    def self.trinkle
      p1  = @p
      @b1 = @b
      @c1 = @c
      r0  = @r1
      t   = @a[r0]
      while p1 > 0
        while (p1 & 1) == 0
          p1       >>= 1
          @b1, @c1 = up(@b1, @c1)
        end
        r3 = @r1 - @b1
        if p1 == 1 or @a[r3] <= t
          p1 = 0
        else
          p1 -= 1
          if @b1 == 1
            @a[@r1] = @a[r3]
            @r1     = r3
          elsif @b1 >= 3
            r2 = @r1 - @b1 + @c1
            if !asc?(@a[@r1 - 1], @a[r2])
              r2       = @r1 - 1
              @b1, @c1 = down(@b1, @c1)
              p1       <<= 1
            end
            if asc?(@a[r2], @a[r3])
              @a[@r1] = @a[r3]
              @r1     = r3
            else
              @a[@r1]  = @a[r2]
              @r1      = r2
              @b1, @c1 = down(@b1, @c1)
              p1       = 0
            end
          end
        end
      end
      if r0 != @r1
        @a[@r1] = t
      end
      sift
    end

    def self.semitrinkle
      @r1 = @r - @c
      if !asc?(@a[@r1], @a[@r])
        @a[@r], @a[@r1] = @a[@r1], @a[@r]
        trinkle
      end
    end

    public

    def self.sort(a)
      @a = a
      @n = @a.length
      @q = 1
      @r = 0
      @p = 1
      @b = 1
      @c = 1
      # build the tree
      while @q < @n
        @r1 = @r
        if (@p & 7) == 3
          @b1 = @b
          @c1 = @c
          sift
          @p     = (@p + 1) >> 2
          @b, @c = up(@b, @c)
          @b, @c = up(@b, @c)
        elsif (@p & 3) == 1
          if (@q + @c) < @n
            @b1 = @b
            @c1 = @c
            sift
          else
            trinkle
          end
          @b, @c = down(@b, @c)
          @p     <<= 1
          while @b > 1
            @b, @c = down(@b, @c)
            @p     <<= 1
          end
          @p += 1
        end
        @q += 1
        @r += 1
      end

      @r1 = @r
      trinkle

      #build the sorted array
      while @q > 1
        @q -= 1
        if @b == 1
          @r -= 1
          @p -= 1
          while (@p & 1) == 0
            @p     >>= 1
            @b, @c = up(@b, @c)
          end
        elsif @b >= 3
          @p -= 1
          @r = @r - @b + @c
          if @p > 0
            semitrinkle
          end
          @b, @c = down(@b, @c)
          @p     = (@p << 1) + 1
          @r     += @c
          semitrinkle
          @b, @c = down(@b, @c)
          @p     = (@p << 1) + 1
          # element q is done
          # element 0 is done
        end
      end
      @a
    end

  end

  def ssort
    SSort.sort(self)
  end
end



