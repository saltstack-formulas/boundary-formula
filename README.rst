========
boundary
========

Install the latest version of Boundary_'s ``boundary-meter``. ``boundary-meter``
has replaced the obsolete ``bprobe`` package, and is compatible with both their
Premium and Enterprise services.

.. _Boundary: http://www.boundary.com/

Available States
================
.. contents::
    :local:

``boundary.boundary-meter``
---------------

Download and install the latest ``boundary-meter`` from
Boundary.com_.

.. _Boundary.com: http://www.boundary.com/

Configuration
=============

Specify at least one or both of the following API tokens in your pillar data.

::

    boundary-meter:
      - enterprise_api_token: <Organization ID>:<API Key>
      - premium_api_token: <API Key>
