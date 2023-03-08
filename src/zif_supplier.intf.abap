"! <p class="shorttext synchronized" lang="EN">Supplier of results</p>
interface zif_supplier public.

  "! <p class="shorttext synchronized" lang="EN">Gets a result</p>
  "!
  "! @parameter r_result | <p class="shorttext synchronized" lang="EN">A result</p>
  methods get
            returning
              value(r_result) type ref to object.

endinterface.
