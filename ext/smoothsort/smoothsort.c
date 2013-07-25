#include <ruby-2.0.0/ruby.h>

/* Adapted from Delphi implementation of Dijkstra's algorithm.
   Second argument to smoothsort added. Functions IsAscending, UP, DOWN
   replaced by macros.
*/

/* Type of items to be sorted; for numeric types, replace by int, float or double */

/* Comparison function; for numeric types, use (A <= B) */

#define IsAscending(A,B) (RTEST(rb_funcall(A, rb_intern("<="), 1, B)))

#define UP(IA,IB)   temp=IA; IA+=IB+1;   IB=temp
#define DOWN(IA,IB) temp=IB; IB=IA-IB-1; IA=temp

static int q, r,
	p, b, c,
	r1, b1, c1;
static VALUE A;

static inline void sift(){
	int r0, r2, temp;
	VALUE T;
	r0 = r1;
	T = rb_ary_entry(A, r0);
	while (b1 >= 3) {
		r2 = r1 - b1 + c1;
		if (!IsAscending(rb_ary_entry(A, r1 - 1), rb_ary_entry(A, r2))) { // A[r1 - 1], A[r2]
			r2 = r1 - 1;
			DOWN(b1,c1);
		}
		if (IsAscending(rb_ary_entry(A, r2), T)) // A[r2]
			b1 = 1;
		else {
			rb_ary_store(A, r1, rb_ary_entry(A, r2)); // A[r1] = A[r2];
			r1 = r2;
			DOWN(b1,c1);
		}
	}
	if (r1 - r0) 
		rb_ary_store(A, r1, T); // A[r1] = T;
}

static inline void trinkle(void){
	int p1,r2,r3, r0, temp;
	VALUE T;
	p1 = p; b1 = b; c1 = c;
	r0 = r1; 
	T = rb_ary_entry(A, r0); //A[r0]
	while (p1 > 0) {
		while ((p1 & 1) == 0) {
			p1 >>= 1;
			UP(b1, c1);
		}
		r3 = r1 - b1;
		if ((p1 == 1) || IsAscending(rb_ary_entry(A, r3), T)) //A[r3]
			p1 = 0;
		else{
			p1--;
			if (b1 == 1) {
				rb_ary_store(A, r1, rb_ary_entry(A, r3)); //A[r1] = A[r3];
				r1 = r3;
			} else if (b1 >= 3) {
				r2 = r1 - b1 + c1;
				if (! IsAscending(rb_ary_entry(A, r1 - 1), rb_ary_entry(A, r2))) { // A[r1 - 1], A[r2]
					r2 = r1 - 1;
					DOWN(b1, c1);
					p1 <<= 1;
				}
				if (IsAscending(rb_ary_entry(A, r2), rb_ary_entry(A, r3))) { // A[r2], A[r3]
					rb_ary_store(A, r1, rb_ary_entry(A, r3)); //A[r1] = A[r3]; 
					r1 = r3;
				} else {
					rb_ary_store(A, r1, rb_ary_entry(A, r2)); //A[r1] = A[r2];
					r1 = r2;
					DOWN(b1, c1);
					p1 = 0;
				}
			}
		}
	}
	if (r0 - r1)
		rb_ary_store(A, r1, T); //A[r1] = T;
	sift();
}

static inline void semitrinkle(void){
	VALUE T;
	r1 = r - c;
	if (! IsAscending(rb_ary_entry(A, r1), rb_ary_entry(A, r))) { //A[r1], A[r]
		T = rb_ary_entry(A, r); //A[r]; 
		rb_ary_store(A, r, rb_ary_entry(A, r1)); //A[r] = A[r1]; 
		rb_ary_store(A, r1, T); //A[r1] = T;
		trinkle();
	}
}

void smoothsort(VALUE self, const int N){
	int temp;
	A = self; /* 0-base array; warning: A is shared by other functions */
	q = 1; r = 0; p = 1; b = 1; c = 1;

	/* building tree */
	while (q < N) {
		r1 = r;
		if ((p & 7) == 3) {
			b1 = b; c1 = c; sift();
			p = (p + 1) >> 2;
			UP(b, c); 
			UP(b, c);
		} else if ((p & 3) == 1) {
			if (q + c < N) {
				b1 = b; c1 = c; sift();
			} else trinkle();
			DOWN(b, c);
			p <<= 1;
			while (b > 1) {
				DOWN(b, c);
				p <<= 1;
			}
			p++;
		}
		q++; r++;
	}
	r1 = r; trinkle();

	/* building sorted array */
	while (q > 1) {
		q--;
		if (b == 1) {
			r--; p--;
			while ((p & 1) == 0) {
				p >>= 1;
				UP(b, c);
			}
		} else if (b >= 3) {
			p--; r = r-b+c;
			if (p > 0) {
				semitrinkle();
			}
			DOWN(b,c);
			p = (p << 1) + 1;
			r = r + c; semitrinkle();
			DOWN(b, c);
			p = (p << 1) + 1;
		}
		/* element q processed */
	}
	/* element 0 processed */
}

/* Sorts an array in-place using the smoothsort algorithm
 * 
 * @return [Array] The sorted array
 */

static VALUE smoothsort_ssort_bang(VALUE self) {
	//return RTEST(rb_funcall(rb_ary_entry(self, 0), rb_intern("<="), 1, rb_ary_entry(self, 1))) ? Qtrue : Qfalse;
	smoothsort(self, (int)RARRAY_LEN(self));
	return self;
}


void Init_smoothsort(void) {
	VALUE module = rb_define_module("Enumerable");
	rb_define_method(module, "ssort!", smoothsort_ssort_bang, 0);
}

