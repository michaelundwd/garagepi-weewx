#
#    Copyright (c) 2009-2020 Tom Keffer <tkeffer@gmail.com>
#
#    See the file LICENSE.txt for your rights.
#
"""wview_mju schema derived from the extended wview schema - Feb 2021"""

# =============================================================================
# This is a list containing the default schema of the archive database.  It is
# only used for initialization --- afterwards, the schema is obtained
# dynamically from the database.  Although a type may be listed here, it may
# not necessarily be supported by your weather station hardware.
# =============================================================================
# NB: This schema is specified using the WeeWX V4 "new-style" schema.
# =============================================================================
table = [('dateTime',             'INTEGER NOT NULL UNIQUE PRIMARY KEY'),
         ('usUnits',              'INTEGER NOT NULL'),
         ('interval',             'INTEGER NOT NULL'),
         ('ET',                   'REAL'),
         ('UV',                   'REAL'),
         ('altimeter',            'REAL'),
         ('barometer',            'REAL'),
         ('dewpoint',             'REAL'),
         ('heatindex',            'REAL'),
         ('inHumidity',           'REAL'),
         ('inTemp',               'REAL'),
         ('maxSolarRad',          'REAL'),
         ('outHumidity',          'REAL'),
         ('outTemp',              'REAL'),
         ('percentRad',           'REAL'),
         ('pressure',             'REAL'),
         ('radiation',            'REAL'),
         ('rain',                 'REAL'),
         ('rainRate',             'REAL'),
         ('txBatteryStatus',      'REAL'),
         ('windDir',              'REAL'),
         ('windGust',             'REAL'),
         ('windGustDir',          'REAL'),
         ('windSpeed',            'REAL'),
         ('windchill',            'REAL'),
         ]

day_summaries = [(e[0], 'scalar') for e in table
                 if e[0] not in ('dateTime', 'usUnits', 'interval')] + [('wind', 'VECTOR')]

schema = {
    'table': table,
    'day_summaries' : day_summaries
}
