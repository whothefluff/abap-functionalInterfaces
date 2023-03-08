"! <p class="shorttext synchronized" lang="EN">A function that accepts one argument and produces a result</p>
class zcl_function definition
                   public
                   abstract
                   create public.

  public section.

    interfaces: zif_function
                  abstract methods
                    apply
                  final methods
                    compose
                    and_then.

    aliases: identity for zif_function~identity.

  protected section.

endclass.



class zcl_function implementation.

  method zif_function~identity.

    r_identity_function = new identity_function( ).

  endmethod.
  method zif_function~compose.

    r_composed_function = i_before->and_then( me ).

  endmethod.
  method zif_function~and_then.

    r_composed_function = cond #( when i_after is bound
                                  then new composed_function( i_current = me
                                                              i_after = i_after )
                                  else throw zcx_null_object_reference( ) ).

  endmethod.

endclass.
