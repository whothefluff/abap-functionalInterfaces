"! <p class="shorttext synchronized" lang="EN">A predicate (boolean-valued function) of one argument</p>
interface zif_predicate public.

  "! <p class="shorttext synchronized" lang="EN">Evaluates this predicate on the given argument</p>
  "!
  "! @parameter i_input | <p class="shorttext synchronized" lang="EN">The input argument</p>
  "! @parameter r_bool | <p class="shorttext synchronized" lang="EN"><em>true</em> if the input argument matches the predicate</p>
  methods test
            importing
              i_input type ref to object
            returning
              value(r_bool) type xsdboolean.

  "! <p class="shorttext synchronized" lang="EN">Returns a predicate for the logical negation of itself</p>
  "!
  "! @parameter r_negated_predicate | <p class="shorttext synchronized" lang="EN">Predicate representing logical negation of this predicate</p>
  methods negate
            default ignore
            returning
              value(r_negated_predicate) type ref to zif_predicate.

" add to abap doc if the version allows to declare no_check excs
" "! @exception zcx_null_object_reference | <p class="shorttext synchronized" lang="EN">If target is null</p>
  "! <p class="shorttext synchronized" lang="EN">Returns a predicate that negates the supplied predicate</p>
  "! This is accomplished by returning result of the calling target-&gt;negate( )
  "!
  "! @parameter i_target | <p class="shorttext synchronized" lang="EN">Predicate to negate</p>
  "! @parameter r_negated_target | <p class="shorttext synchronized" lang="EN">A predicate negating the results of the supplied predicate</p>
  class-methods not
                  default ignore
                  importing
                    i_target type ref to zif_predicate
                  returning
                    value(r_negated_target) type ref to zif_predicate.

" add to abap doc if the version allows to declare no_check excs
" "! @exception zcx_null_object_reference | <p class="shorttext synchronized" lang="EN">If other is null</p>
  "! <p class="shorttext synchronized" lang="EN">Returns a new predicate for a short-circuiting logical AND</p>
  "! Returns a composed predicate that represents a short-circuiting logical AND of this predicate and another.
  "! When evaluating the composed predicate, if this predicate is <em>false</em>, then the other predicate is not evaluated.
  "! <br/>Any exceptions thrown during evaluation of either predicate are relayed to the caller;
  "! if evaluation of this predicate throws an exception, the other predicate will not be evaluated.
  "!
  "! @parameter i_other | <p class="shorttext synchronized" lang="EN">A predicate that will be logically-ANDed with this predicate</p>
  "! @parameter r_composed_predicate | <p class="shorttext synchronized" lang="EN">A composed predicate</p>
  methods and
            default ignore
            importing
              i_other type ref to zif_predicate
            returning
              value(r_composed_predicate) type ref to zif_predicate.

" add to abap doc if the version allows to declare no_check excs
" "! @exception zcx_null_object_reference | <p class="shorttext synchronized" lang="EN">If other is null</p>
  "! <p class="shorttext synchronized" lang="EN">Returns a new predicate for a short-circuiting logical OR</p>
  "! Returns a composed predicate that represents a short-circuiting logical OR of this predicate and another.
  "! When evaluating the composed predicate, if this predicate is <em>true</em>, then the other predicate is not evaluated.
  "! <br/>Any exceptions thrown during evaluation of either predicate are relayed to the caller;
  "! if evaluation of this predicate throws an exception, the other predicate will not be evaluated.
  "!
  "! @parameter i_other | <p class="shorttext synchronized" lang="EN">A predicate that will be logically-ORed with this predicate</p>
  "! @parameter r_composed_predicate | <p class="shorttext synchronized" lang="EN">A composed predicate</p>
  methods or
            default ignore
            importing
              i_other type ref to zif_predicate
            returning
              value(r_composed_predicate) type ref to zif_predicate.

  "! <p class="shorttext synchronized" lang="EN">Returns a predicate that tests if two arguments are equal</p>
  "!
  "! @parameter i_target | <p class="shorttext synchronized" lang="EN">The object with which to compare, which may be null</p>
  "! @parameter r_equality_predicate | <p class="shorttext synchronized" lang="EN">A predicate that tests if two arguments are equal</p>
  class-methods is_equal
                  default ignore
                  importing
                    i_target type ref to object
                  returning
                    value(r_equality_predicate) type ref to zif_predicate.

endinterface.
