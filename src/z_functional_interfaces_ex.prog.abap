report z_functional_interfaces_ex.

"runnable
"**********************************************************************
class user_of_some_runnable_process definition "#EC CLAS_FINAL
                                    create public.

  public section.

    methods use
              importing
                i_process type ref to zif_runnable.

  protected section.

endclass.
class some_runnable_process definition "#EC CLAS_FINAL
                            create public.

  public section.

    interfaces: zif_runnable.

  protected section.

endclass.

class user_of_some_runnable_process implementation.

  method use.

    i_process->run( ).

  endmethod.

endclass.
class some_runnable_process implementation.

  method zif_runnable~run.

    write / 'runnable executed'.

  endmethod.

endclass.

"supplier
"**********************************************************************
class user_of_supplier definition "#EC CLAS_FINAL
                       create public.

  public section.

    methods get_from
              importing
                i_supplier type ref to zif_supplier
              returning
                value(r_result) type ref to zcl_free_msg.

  protected section.

endclass.
class message_supplier definition "#EC CLAS_FINAL
                       create public.

  public section.

    interfaces: zif_supplier.

    methods get
              returning
                value(r_result) type ref to zcl_free_msg.

  protected section.

endclass.

class user_of_supplier implementation.

  method get_from.

    r_result = cast #( i_supplier->get( ) ).

  endmethod.

endclass.
class message_supplier implementation.

  method zif_supplier~get.

    r_result = me->get( ).

  endmethod.
  method get.

    r_result = new zcl_free_msg( `Message created through supplier` ).

  endmethod.

endclass.

"consumer
"**********************************************************************
class name_printer definition "#EC CLAS_FINAL
                   create public
                   inheriting from zcl_consumer.

  public section.

    methods zif_consumer~accept redefinition.

endclass.
class name_length_printer definition "#EC CLAS_FINAL
                          create public
                          inheriting from zcl_consumer.

  public section.

    methods zif_consumer~accept redefinition.

endclass.
class name_colored_printer definition "#EC CLAS_FINAL
                           create public
                           inheriting from zcl_consumer.

  public section.

    methods zif_consumer~accept redefinition.

endclass.

class name_colored_printer implementation.

  method zif_consumer~accept.

    write / cast zcl_msg( i_input )->get_text( ) color col_heading.

  endmethod.

endclass.

class name_printer implementation.

  method zif_consumer~accept.

    write / cast zcl_msg( i_input )->get_text( ).

  endmethod.

endclass.
class name_length_printer implementation.

  method zif_consumer~accept.

    data(text) = cast zcl_msg( i_input )->get_text( ).

    write / strlen( text ).

  endmethod.

endclass.

"function
"**********************************************************************
class multiplication_by_2 definition "#EC CLAS_FINAL
                          create public
                          inheriting from zcl_function.

  public section.

    methods: zif_function~apply redefinition.

  protected section.

endclass.
class subtraction_of_1 definition "#EC CLAS_FINAL
                       create public
                       inheriting from zcl_function.

  public section.

    methods: zif_function~apply redefinition.

  protected section.

endclass.
class integer definition "#EC CLAS_FINAL
              create public.

  public section.

    types t_value type i.

    methods constructor
              importing
                i_value type integer=>t_value.

    methods value
              returning
                value(r_value) type integer=>t_value.

  protected section.

    data a_value type integer=>t_value.

endclass.
class integer implementation.

  method constructor.

    me->a_value = i_value.

  endmethod.
  method value.

    r_value = me->a_value.

  endmethod.

endclass.
class multiplication_by_2 implementation.

  method zif_function~apply.

    r_result = new integer( cast integer( i_input )->value( ) * 2 ).

  endmethod.

endclass.
class subtraction_of_1 implementation.

  method zif_function~apply.

    r_result = new integer( cast integer( i_input )->value( ) - 1 ).

  endmethod.

endclass.

"predicate
"**********************************************************************
class local_class definition "#EC CLAS_FINAL
                     create public.

  public section.

*    methods .

  protected section.

endclass.
class local_class implementation.

endclass.

start-of-selection.

"runnable
"**********************************************************************
  write / `runnable:` color col_group.

  "1
  data(user_of_some_process) = new user_of_some_runnable_process( ).

  data(some_process) = cast zif_runnable( new some_runnable_process( ) ).

  user_of_some_process->use( some_process ).

  "2
  new user_of_some_runnable_process( )->use( new some_runnable_process( ) ).

"supplier
"**********************************************************************
  write /.
  write / `supplier:` color col_group.

  "1
  data(user_of_supplier) = new user_of_supplier( ).

  data(supplier) = new message_supplier( ).

  data(supplier_result) = user_of_supplier->get_from( supplier ).

  "2
  data(supplier_result2) = new user_of_supplier( )->get_from( new message_supplier( ) ).

"consumer
"**********************************************************************
  write /.
  write / `consumer:` color col_group.

  data(message_printer) = cast zif_consumer( new name_printer( ) ).

  data(message_length_printer) = cast zif_consumer( new name_length_printer( ) ).

  data(message_colored_printer) = cast zif_consumer( new name_colored_printer( ) ).

  data(message_name_length_printer) = message_printer->and_then( message_length_printer )->and_then( message_colored_printer )->and_then( message_length_printer ).

  message_name_length_printer->accept( new zcl_free_msg( `John` ) ).

"function
"**********************************************************************
  write /.
  write / `function:` color col_group.

  data(random_gen) = cl_abap_random_int=>create( ).

  data(multiplication_by_2) = cast zif_function( new multiplication_by_2( ) ).

  data(subtraction_of_1) = cast zif_function( new subtraction_of_1( ) ).

  do 3 times.

    data(random_int) = new integer( random_gen->get_next( ) ).

    write / |original number { random_int->value( ) }| color col_key.

    data(some_function) = multiplication_by_2->and_then( subtraction_of_1->compose( multiplication_by_2 ) ).

    write / |identity number { cast integer( some_function->identity( )->apply( random_int ) )->value( ) }|.

    write / |andThen number { cast integer( multiplication_by_2->and_then( subtraction_of_1 )->apply( random_int ) )->value( ) }|.

    write / |compose number { cast integer( subtraction_of_1->compose( multiplication_by_2 )->apply( random_int ) )->value( ) }|.

  enddo.

"predicate
"**********************************************************************
  write /.
  write / `predicate:` color col_group.

  try.

  data(some_object) = new integer( 0 ).

  data(some_object_equality) = zcl_predicate=>is_equal( some_object ).

  write / |equals same object: { some_object_equality->test( some_object ) xsd = yes }|.

  write / |equals different object: { some_object_equality->test( new zcl_free_msg( `` ) ) xsd = yes }|.

  write / |equals initial object: { some_object_equality->test( value #( ) ) xsd = yes }|.

  "and, or, negate, not

  catch cx_root.

  endtry.

  break-point.
