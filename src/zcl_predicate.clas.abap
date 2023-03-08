"! <p class="shorttext synchronized" lang="EN">A predicate (boolean-valued function) of one argument</p>
class zcl_predicate definition
                    public
                    abstract
                    create public.

  public section.

    interfaces: zif_predicate
                  abstract methods
                    test
                  final methods
                    negate
                    and
                    or.

    aliases: is_equal for zif_predicate~is_equal,
             not for zif_predicate~not.

  protected section.

endclass.



class zcl_predicate implementation.

  method zif_predicate~and.

    r_composed_predicate = cond #( when i_other is bound
                                   then new composed_and_predicate( i_current = me
                                                                    i_other = i_other )
                                   else throw zcx_null_object_reference( ) ).

  endmethod.
  method zif_predicate~is_equal.

    r_equality_predicate = new equality_predicate( i_target ).

  endmethod.
  method zif_predicate~negate.

    r_negated_predicate = new negated_predicate( me ).

  endmethod.
  method zif_predicate~not.

    r_negated_target = i_target->negate( ).

  endmethod.
  method zif_predicate~or.

    r_composed_predicate = cond #( when i_other is bound
                                   then new composed_or_predicate( i_current = me
                                                                   i_other = i_other )
                                   else throw zcx_null_object_reference( ) ).

  endmethod.

endclass.
