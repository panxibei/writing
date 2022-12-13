通过ADO调用ODBC连接的第三方驱动程序

副标题：通过ADO调用ODBC连接的第三方驱动程序

英文：calling-odbc-from-ado-to-connect-to-thirdparty-driver

关键字：odbc,ado,vb,database,driver







```vb
'''Calling ODBC from ADO to connect to thirdparty driver

Dim ADOCN As New ADODB.Connection
Dim ADORS As New ADODB.Recordset
Dim mysql As String

With ADOCN
   'here how to call odbc from ADO!
   .ConnectionString = "DSN=odbc namet;UID=YOURUSERID;PWD=YOURPASSWORD;"
   .Mode = adModeReadOnly
   .Open
End With

With ADORS
   .CursorLocation = adUseClient
   .CursorType = adOpenKeyset
   .LockType = adLockOptimistic
   .ActiveConnection = ADOCN
    mysql = "select whatever from my table"
   .Source = mysql
   .Open
   
   'for good preformance, I did store the record set in variant type variable so I can disconnect from host sooner

   .ctiveConnection = Nothing
    myrows = .RecordCount
    mycola = .Fields.Count
    mydata = .GetRows()
    
End With

'now I can loop through my result
```
<br><br>