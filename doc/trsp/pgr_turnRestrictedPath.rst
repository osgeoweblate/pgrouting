..
   ****************************************************************************
    pgRouting Manual
    Copyright(c) pgRouting Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

|

* **Supported versions:**
  `Latest <https://docs.pgrouting.org/latest/en/pgr_turnRestrictedPath.html>`__
  (`3.3 <https://docs.pgrouting.org/3.3/en/pgr_turnRestrictedPath.html>`__)
  `3.2 <https://docs.pgrouting.org/3.2/en/pgr_turnRestrictedPath.html>`__
  `3.1 <https://docs.pgrouting.org/3.1/en/pgr_turnRestrictedPath.html>`__
  `3.0 <https://docs.pgrouting.org/3.0/en/pgr_turnRestrictedPath.html>`__

pgr_turnRestrictedPath - Experimental
===============================================================================

``pgr_turnRestrictedPath``

.. include:: experimental.rst
   :start-after: begin-warn-expr
   :end-before: end-warn-expr

.. rubric:: Availability

* Version 3.0.0

  * New **Experimental** function


Description
-------------------------------------------------------------------------------

* TBD

Signatures
-------------------------------------------------------------------------------

.. rubric:: Summary

.. index::
   single: turnRestrictedPath - Experimental on v3.0

.. code-block:: none

    pgr_turnRestrictedPath(Edges SQL, Restrictions SQL, Start vertex, End vertex, K cycles,
      [, directed] [,heap_paths] [, stop_on_first] [,strict])
    RETURNS SETOF (seq, path_id, path_seq, node, edge, cost, agg_cost)

Parameters
-------------------------------------------------------------------------------
* TBD

Parameters
-------------------------------------------------------------------------------

* TBD

Inner query
-------------------------------------------------------------------------------

* TBD

Result Columns
-------------------------------------------------------------------------------

* TBD

Additional Examples
-------------------------------------------------------------------------------

:Example:

See Also
-------------------------------------------------------------------------------

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`

