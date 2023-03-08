"! <p class="shorttext synchronized" lang="EN">A function that accepts one argument and produces a result</p>
interface zif_function public.

  "! <p class="shorttext synchronized" lang="EN">Applies this function to the given argument</p>
  "!
  "! @parameter i_input | <p class="shorttext synchronized" lang="EN">The function argument</p>
  "! @parameter r_result | <p class="shorttext synchronized" lang="EN">The function result</p>
  methods apply
            importing
              i_input type ref to object
            returning
              value(r_result) type ref to object.

  "! <p class="shorttext synchronized" lang="EN">Returns a function that always returns its input argument</p>
  "!
  "! @parameter r_identity_function | <p class="shorttext synchronized" lang="EN">A function that always returns its input argument</p>
  class-methods identity
                  default ignore
                  returning
                    value(r_identity_function) type ref to zif_function.

" add to abap doc if the version allows to declare no_check excs
" "! @exception zcx_null_object_reference | <p class="shorttext synchronized" lang="EN">If before is null</p>
  "! <p class="shorttext synchronized" lang="EN">Returns a composed Function</p>
  "! The new function first applies the before function to its input, and then applies this function to the result
  "! <br/>If evaluation of either function throws an exception, it is relayed to the caller of the composed function
  "!
  "! @parameter i_before | <p class="shorttext synchronized" lang="EN">The function to apply before this function is applied</p>
  "! @parameter r_composed_function | <p class="shorttext synchronized" lang="EN">A composed function that first applies the before function</p>
  methods compose
            default ignore
            importing
              i_before type ref to zif_function
            returning
              value(r_composed_function) type ref to zif_function.

" add to abap doc if the version allows to declare no_check excs
" "! @exception zcx_null_object_reference | <p class="shorttext synchronized" lang="EN">If after is null</p>
  "! <p class="shorttext synchronized" lang="EN">Returns a composed Function</p>
  "! The new function first applies this function to its input, and then applies the after function to the result.
  "! <br/>If evaluation of either function throws an exception, it is relayed to the caller of the composed function.
  "!
  "! @parameter i_after | <p class="shorttext synchronized" lang="EN">The function to apply after this function is applied</p>
  "! @parameter r_composed_function | <p class="shorttext synchronized" lang="EN">A composed function that first applies this function</p>
  methods and_then
            default ignore
            importing
              i_after type ref to zif_function
            returning
              value(r_composed_function) type ref to zif_function.

endinterface.
