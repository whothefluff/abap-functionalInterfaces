*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class identity_function definition "#EC CLAS_FINAL
                        create public
                        inheriting from zcl_function.

  public section.

    methods: zif_function~apply redefinition.

  protected section.

endclass.
class identity_function implementation.

  method zif_function~apply.

    r_result = i_input.

  endmethod.

endclass.
class composed_function definition "#EC CLAS_FINAL
                        create public
                        inheriting from zcl_function.

  public section.

    methods constructor
              importing
                i_current type ref to zif_function
                i_after type ref to zif_function.

    methods zif_function~apply redefinition.

  protected section.

    data a_current type ref to zif_function.

    data an_after type ref to zif_function.

endclass.
class composed_function implementation.

  method constructor.

    super->constructor( ).

    me->a_current = i_current.

    me->an_after = i_after.

  endmethod.
  method zif_function~apply.

    r_result = me->an_after->apply( me->a_current->apply( i_input ) ).

  endmethod.

endclass.
