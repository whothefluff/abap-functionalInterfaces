"! <p class="shorttext synchronized" lang="EN">Operation that accepts a single input argument</p>
class zcl_consumer definition
                   public
                   abstract
                   create public.

  public section.

    interfaces: zif_consumer
                  abstract methods
                    accept
                  final methods
                    and_then.

  protected section.

endclass.



class zcl_consumer implementation.

  method zif_consumer~and_then.

    r_composed_consumer = cond #( when i_after is bound
                                  then new composed_consumer( i_current = me
                                                              i_after = i_after )
                                  else throw zcx_null_object_reference( ) ).

  endmethod.

endclass.
