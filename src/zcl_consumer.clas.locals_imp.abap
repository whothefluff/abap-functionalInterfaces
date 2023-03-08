*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class composed_consumer definition "#EC CLAS_FINAL
                        create public
                        inheriting from zcl_consumer.

  public section.

    methods: zif_consumer~accept redefinition.

    methods constructor
              importing
                i_current type ref to zif_consumer
                i_after type ref to zif_consumer.

  protected section.

    data a_current type ref to zif_consumer.

    data an_after type ref to zif_consumer.

endclass.
class composed_consumer implementation.

  method constructor.

    super->constructor( ).

    me->a_current = i_current.

    me->an_after = i_after.

  endmethod.
  method zif_consumer~accept.

    me->a_current->accept( i_input ).

    me->an_after->accept( i_input ).

  endmethod.

endclass.
