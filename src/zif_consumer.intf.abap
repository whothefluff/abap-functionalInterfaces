"! <p class="shorttext synchronized" lang="EN">Operation that accepts a single input argument</p>
"! Returns no result
interface zif_consumer public.

  "! <p class="shorttext synchronized" lang="EN">Performs this operation on the given argument</p>
  "!
  "! @parameter i_input | <p class="shorttext synchronized" lang="EN">The input argument</p>
  methods accept
            importing
              i_input type ref to object.


" add to abap doc if the version allows to declare no_check excs
" "! @exception zcx_null_object_reference | <p class="shorttext synchronized" lang="EN">If after is null</p>
  "! <p class="shorttext synchronized" lang="EN">Returns a composed Consumer</p>
  "!  The new consumer performs, in sequence, this operation followed by the after operation
  "!
  "! @parameter i_after | <p class="shorttext synchronized" lang="EN">The operation to perform after this operation</p>
  "! @parameter r_consumer | <p class="shorttext synchronized" lang="EN">A composed Consumer that performs the operations in sequence</p>
  methods and_then
            default ignore
            importing
              i_after type ref to zif_consumer
            returning
              value(r_composed_consumer) type ref to zif_consumer.

endinterface.
