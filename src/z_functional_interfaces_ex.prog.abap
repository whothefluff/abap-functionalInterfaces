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

    write / 'runnable executed' ##NO_TEXT.

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

    r_result = new zcl_free_msg( `Message created through supplier` ) ##NO_TEXT.

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
class checker_starts_with definition "#EC CLAS_FINAL
                          create public
                          inheriting from zcl_predicate.

  public section.

    types t_string type string.

    methods constructor
              importing
                i_string type checker_starts_with=>t_string.

    methods: zif_predicate~test redefinition.

  protected section.

    data a_string type checker_starts_with=>t_string.

endclass.
class checker_starts_with implementation.

  method zif_predicate~test.

    r_bool = xsdbool( cast zcl_msg( i_input )->get_text( ) ca me->a_string && '*' ).

  endmethod.
  method constructor.

    super->constructor( ).

    me->a_string = i_string.

  endmethod.

endclass.
class checker_ends_with_number definition "#EC CLAS_FINAL
                               create public
                               inheriting from zcl_predicate.

  public section.

    methods: zif_predicate~test redefinition.

  protected section.

endclass.
class checker_ends_with_number implementation.

  method zif_predicate~test.

    data(input_msg) = cast if_message( i_input )->get_text( ).

    r_bool = xsdbool( input_msg is not initial
                      and contains( val = input_msg
                                    off = strlen( input_msg )
                                    regex = `\d` ) ).

  endmethod.

endclass.

start-of-selection.

"runnable
"**********************************************************************
  write / `runnable:` color col_group ##NO_TEXT.

  "1
  data(user_of_some_process) = new user_of_some_runnable_process( ).

  data(some_process) = cast zif_runnable( new some_runnable_process( ) ).

  user_of_some_process->use( some_process ).

  "2
  new user_of_some_runnable_process( )->use( new some_runnable_process( ) ).

"supplier
"**********************************************************************
  write /.
  write / `supplier:` color col_group ##NO_TEXT.

  "1
  data(user_of_supplier) = new user_of_supplier( ).

  data(supplier) = new message_supplier( ).

  data(supplier_result) = user_of_supplier->get_from( supplier ).

  write / supplier_result->get_text( ).

  "2
  data(supplier_result2) = new user_of_supplier( )->get_from( new message_supplier( ) ).

  write / supplier_result2->get_text( ).

"consumer
"**********************************************************************
  write /.
  write / `consumer:` color col_group ##NO_TEXT.

  data(write_name) = cast zif_consumer( new name_printer( ) ).

  data(write_name_length) = cast zif_consumer( new name_length_printer( ) ).

  data(write_name_in_different_color) = cast zif_consumer( new name_colored_printer( ) ).

  data(message_name_length_printer) = write_name->and_then( write_name_length )->and_then( write_name_in_different_color )->and_then( write_name_length ).

  message_name_length_printer->accept( new zcl_free_msg( `John` ) ) ##NO_TEXT.

"function
"**********************************************************************
  write /.
  write / `function:` color col_group ##NO_TEXT.

  data(random_gen) = cl_abap_random_int=>create( ).

  data(multiply_by_2) = cast zif_function( new multiplication_by_2( ) ).

  data(subtract_1) = cast zif_function( new subtraction_of_1( ) ).

  do 3 times.

    data(random_int) = new integer( random_gen->get_next( ) ).

    write / |original number { random_int->value( ) }| color col_key.

    data(some_function) = multiply_by_2->and_then( subtract_1->compose( multiply_by_2 ) ).

    write / |identity number { cast integer( some_function->identity( )->apply( random_int ) )->value( ) }|.

    write / |andThen number { cast integer( multiply_by_2->and_then( subtract_1 )->apply( random_int ) )->value( ) }|.

    write / |compose number { cast integer( subtract_1->compose( multiply_by_2 )->apply( random_int ) )->value( ) }|.

  enddo.

"predicate
"**********************************************************************
  write /.
  write / `predicate:` color col_group ##NO_TEXT.

  data(some_object) = new integer( 0 ).

  data(some_object_equality) = zcl_predicate=>is_equal( some_object ).

  "is_equal
  write / |equals same: { some_object_equality->test( some_object ) xsd = yes }|.

  write / |equals different: { some_object_equality->test( new zcl_free_msg( `` ) ) xsd = yes }|.

  write / |equals initial: { some_object_equality->test( value #( ) ) xsd = yes }|.

  "and
  data(some_msg) = new zcl_free_msg( `Alo` ).

  data(starts_with_upper_a) = cast zif_predicate( new checker_starts_with( `A` ) ).

  data(starts_with_lower_z) = cast zif_predicate( new checker_starts_with( `z` ) ).

  data(ends_with_number) = cast zif_predicate( new checker_ends_with_number( ) ).

  data(doesnt_end_with_a_number) = ends_with_number->negate( ). "negate

  write / |true and false: { starts_with_upper_a->and( ends_with_number )->test( some_msg ) xsd = yes }|.

  write / |false and true: { ends_with_number->and( starts_with_upper_a )->test( some_msg ) xsd = yes }|.

  write / |false and false: { starts_with_lower_z->and( ends_with_number )->test( some_msg ) xsd = yes }|.

  write / |true and true: { starts_with_upper_a->and( doesnt_end_with_a_number )->test( some_msg ) xsd = yes }|.

  "or
  write / |true or false: { starts_with_upper_a->or( ends_with_number )->test( some_msg ) xsd = yes }|.

  write / |false or true: { ends_with_number->or( starts_with_upper_a )->test( some_msg ) xsd = yes }|.

  write / |false or false: { starts_with_lower_z->or( ends_with_number )->test( some_msg ) xsd = yes }|.

  write / |true or true: { starts_with_upper_a->or( doesnt_end_with_a_number )->test( some_msg ) xsd = yes }|.

  "not
  data(doesnt_start_with_lower_z) = zcl_predicate=>not( starts_with_lower_z ).

  write / |not false: { doesnt_start_with_lower_z->test( some_msg ) xsd = yes }|.
