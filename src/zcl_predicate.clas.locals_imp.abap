*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class equality_predicate definition "#EC CLAS_FINAL
                         create public
                         inheriting from zcl_predicate.

  public section.

    methods constructor
              importing
                i_target_ref type ref to object.

    methods: zif_predicate~test redefinition.

  protected section.

    data a_target_ref type ref to object.

endclass.
class equality_predicate implementation.

  method constructor.

    super->constructor( ).

    me->a_target_ref = i_target_ref.

  endmethod.
  method zif_predicate~test.

    r_bool = xsdbool( me->a_target_ref is bound
                      and i_input is bound
                      and me->a_target_ref eq i_input ).

  endmethod.

endclass.
class negated_predicate definition "#EC CLAS_FINAL
                        create public
                        inheriting from zcl_predicate.
  PUBLIC SECTION.

    methods constructor
              importing
                i_original_predicate type ref to zif_predicate.

    methods: zif_predicate~test redefinition.

  protected section.

    data a_negated_bool type xsdboolean.

endclass.
class negated_predicate implementation.

  method constructor.

    super->constructor( ).

*    a_negated_bool = i_original_predicate->test( ).

  endmethod.
  method zif_predicate~test.

*    r_bool = me->a_negated_bool.

  endmethod.

endclass.
class composed_predicate definition "#EC CLAS_FINAL
                         abstract
                         create public
                         inheriting from zcl_predicate.

  public section.

    methods constructor
              importing
                i_current type ref to zif_predicate
                i_other type ref to zif_predicate.

  protected section.

    data a_current type ref to zif_predicate.

    data an_other type ref to zif_predicate.

endclass.
class composed_predicate implementation.

  method constructor.

    super->constructor( ).

    me->a_current = i_current.

    me->an_other = i_other.

  endmethod.

endclass.
class composed_and_predicate definition "#EC CLAS_FINAL
                             create public
                             inheriting from composed_predicate.

  public section.

    methods zif_predicate~test redefinition.

endclass.
class composed_and_predicate implementation.

  method zif_predicate~test.

    r_bool = xsdbool( me->a_current->test( i_input )
                      and me->an_other->test( i_input ) ).

  endmethod.

endclass.
class composed_or_predicate definition "#EC CLAS_FINAL
                            create public
                            inheriting from composed_predicate.

  public section.

    methods zif_predicate~test redefinition.

endclass.
class composed_or_predicate implementation.

  method zif_predicate~test.

    r_bool = xsdbool( me->a_current->test( i_input )
                      or me->an_other->test( i_input ) ).

  endmethod.

endclass.
