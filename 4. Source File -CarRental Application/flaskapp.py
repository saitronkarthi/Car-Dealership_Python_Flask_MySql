from flask import Flask,render_template,request
import pymysql
from datetime import datetime

hostname = 'xxxxxxxx' 
username = 'xxxxxx'
password = 'xxxxx'
database = 'rentals'
# credentials removed
myConnection = pymysql.connect(host=hostname, user=username, passwd=password, db=database)
print 'connected'
app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('Rentalapp.html',lcustdis='none',custdis='none',lcardis='none',cardis='none',
                           rentdis='none',arentdis='none',retrentdis='none',lretrentdis='none',allretrentdis='none',allavailrentdis='none')

@app.route('/customer', methods=['GET','POST'])
def customer():
    if request.method == 'POST':
        results=[]
        cur = myConnection.cursor()
        cid = request.form['txtCustomerId']
        cname=request.form['txtCustomerName']
        dlno =request.form['txtCustomerDLNo']
        phone =request.form['txtPhone']
        cur.callproc('sp_InsertCustomer',(cid,  cname, dlno,  phone))
        myConnection.commit()
        query = "select * from customer order by Customer_Id DESC "
        cur.execute(query)
        result = cur.fetchall()
        for res in result:
            results.append(res)
        cur.close()
        return render_template('Rentalapp.html',custdis='inherit',lcustdis='inherit',lcardis='none',cardis='none',
                               rentdis='none', arentdis='none',retrentdis='none',lretrentdis='none',Customers=results,
                               allretrentdis='none',allavailrentdis='none')

@app.route('/showCustomer/<cid>',methods=['GET', 'POST'])
def showCustomer(cid):
    custidval = cid
    if custidval == "0":
        query = "select * from customer order by Customer_Id DESC "

        results = []
        cur = myConnection.cursor()
        cur.execute(query)
        result = cur.fetchall()
        for res in result:
            results.append(res)
        cur.close()
        return render_template('Rentalapp.html',custdis='inherit', lcustdis='none',lcardis='none',cardis='none',
                               rentdis='none',arentdis='none',retrentdis='none',lretrentdis='none',Customers=results,
                               allretrentdis='none',allavailrentdis='none')
    else:
        query = "select * from customer where Customer_Id= "+custidval
        results = []
        cur = myConnection.cursor()
        cur.execute(query)
        result = cur.fetchall()

        for res in result:
            results.append(res)
        cur.close()
        myjson=str(res[0])+ ','+str(res[1])+ ','+str(res[2])+ ','+str(res[3])
        return myjson


@app.route('/car', methods=['GET', 'POST'])
def car():
    if request.method == 'POST':
        results = []
        cur = myConnection.cursor()
        vehicleid = request.form['txtVehicleId']
        licenseplateno = request.form['txtLicensePlateNo']
        model = request.form['txtModel']
        year = request.form['txtYear']
        dailyrate = request.form['txtDailyRate']
        weeklyrate = request.form['txtWeeklyRate']
        Cartype = request.form.get('cartype')

        cur.callproc('sp_InsertCar', (vehicleid, licenseplateno, model, year,dailyrate,weeklyrate,Cartype))
        myConnection.commit()
        query = "select * from car order by Vehicle_Id DESC "
        cur.execute(query)
        result = cur.fetchall()
        for res in result:
            results.append(res)
        cur.close()
        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='inherit', cardis='inherit',
                               rentdis='none',arentdis='none',retrentdis='none',lretrentdis='none',Cars=results,
                               allretrentdis='none',allavailrentdis='none')


@app.route('/showCar/<carid>', methods=['GET', 'POST'])
def showCar(carid):
    vehicleid = carid
    if vehicleid == "0":

        query = "select * from car order by Vehicle_Id DESC "
        results = []
        cur = myConnection.cursor()
        cur.execute(query)
        result = cur.fetchall()
        for res in result:
            results.append(res)
        cur.close()

        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='inherit',
                               rentdis='none',arentdis='none',retrentdis='none',lretrentdis='none',Cars=results,
                               allretrentdis='none',allavailrentdis='none')
    else:
        query = "select * from car where Vehicle_Id= " + vehicleid
        results = []
        cur = myConnection.cursor()
        cur.execute(query)
        result = cur.fetchall()

        for res in result:
            results.append(res)

            myjson = str(res[0]) + ',' + str(res[1]) + ',' + str(res[2]) + ',' + str(res[3])+',' +str(res[4])+',' + str(res[5])+',' + str(res[6])

        return myjson


@app.route('/GetRental', methods=['GET', 'POST'])
def GetRental():
    # if request.method == 'POST':
    # querycust = "select Customer_Id,CONCAT(Customer_Name, '  -  ', Customer_DLNo) as Cname from Customer order by Customer_Name"
    # resultscust = []
    # cur = myConnection.cursor()
    # cur.execute(querycust)
    # resultitem = cur.fetchall()
    #
    # for res in resultitem:
    #     resultscust.append(res)
    # cur.close()


    return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                           rentdis='inherit',arentdis='none',retrentdis='none',lretrentdis='none',allretrentdis='none',
                           allavailrentdis='none')



@app.route('/showAvailableCars', methods=['GET', 'POST'])
def showAvailableCars():
    if request.method == 'POST':
        results = []
        cur = myConnection.cursor()
        Cartype = request.form.get('acartype')
        renttype = request.form.get('renttype')
        # stdate=datetime.strptime(request.form['datepicker'], '%Y-%m-%d').date()
        stdate = request.form.get('datepicker')
        # stdate=request.form['datepicker("getdate")']

        if(renttype=="D"):
         daysorweeks = request.form['txtNoofDays']
        else:
         daysorweeks = request.form['txtNoofWeeks']
        cur.callproc('sp_GetAvailCardet', (Cartype, renttype,stdate, daysorweeks))
        myConnection.commit()
        # for result in cur.stored_results():
        result = cur.fetchall()
        for res in result:
            results.append(res)
        querycust = "select Customer_Id,CONCAT(Customer_Name, '  -  ', Customer_DLNo) as Cname from customer where Customer_Id not in (select  R_Customer_Id from rentals) order by Customer_Name"
        resultscust = []
        cur = myConnection.cursor()
        cur.execute(querycust)
        resultitem = cur.fetchall()

        for res in resultitem:
            resultscust.append(res)
        cur.close()
        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='inherit', arentdis='inherit', AvailCars=results, retrentdis='none',lretrentdis='none',Customers=resultscust,
                               allretrentdis='none',allavailrentdis='none')
    if request.method == 'GET':

        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='inherit', arentdis='none',retrentdis='none',lretrentdis='none',
                               allretrentdis='none',allavailrentdis='none'
                               )


@app.route('/rentals', methods=['GET', 'POST'])
def rentals():
     if request.method == 'POST':
        results = []
        cur = myConnection.cursor()
        custid = request.json['custid']
        vid=request.json['vehid']
        rentype=request.json['rtype']
        stdate=request.json['startdate']
        dw=request.json['dayweek']
        if(rentype=="Daily"):
            dwflag='D'
        else:
            dwflag='W'
        cur.callproc('sp_InsertRentals', (custid, vid, dwflag, stdate,dw))
        myConnection.commit()
        # myjson = str("Success")
        # return myjson
        cur.close()
        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='inherit', arentdis='none',retrentdis='none',lretrentdis='none',
                               allretrentdis='none',allavailrentdis='none')

@app.route('/ReturnRentals/<vid>,<cid>',methods=['GET', 'POST'])
def ReturnRentals(vid,cid):
    resultsret = []
    cur = myConnection.cursor()
    cur.callproc('sp_GetRentals', (vid, cid,'T'))
    myConnection.commit()
    result = cur.fetchall()
    for res in result:
        resultsret.append(res)
    cur.close()
    if(vid=="0"):
      return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                           rentdis='none', arentdis='none',retrentdis='inherit',lretrentdis='none',RetRentals=resultsret,
                             allretrentdis='none',allavailrentdis='none')
    else:
        resultsret = []
        cur = myConnection.cursor()
        cur.callproc('sp_GetRentals', (vid, cid,'T'))
        myConnection.commit()
        result = cur.fetchall()
        for res in result:
            resultsret.append(res)
        cur.close()
        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='none', arentdis='none', retrentdis='inherit', lretrentdis='inherit',
                               RetRentals=resultsret,allretrentdis='none',allavailrentdis='none')

@app.route('/showAllRentals/<vid>,<cid>',methods=['GET', 'POST'])
def showAllRentals(vid,cid):
    resultsret = []
    cur = myConnection.cursor()
    cur.callproc('sp_GetRentals', (vid, cid,'R'))
    myConnection.commit()
    result = cur.fetchall()
    for res in result:
        resultsret.append(res)
    cur.close()
    return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                           rentdis='none', arentdis='none',retrentdis='none',lretrentdis='none',AllRetRentals=resultsret,
                             allretrentdis='inherit',allavailrentdis='none')


@app.route('/showAllAvailRentals',methods=['GET', 'POST'])
def showAllAvailRentals():
    stdate = request.form.get('datepickerst')
    enddate= request.form.get('datepickerend')

    if(stdate==None):
        resultsavailno = []

        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='none', arentdis='none', retrentdis='none', lretrentdis='none',
                               AllRetRentals='none',
                               allretrentdis='none', allavailrentdis='inherit', AllAvailRentals=resultsavailno)


    elif(stdate==""):
        resultsavailno = []

        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='none', arentdis='none', retrentdis='none', lretrentdis='none',
                               AllRetRentals='none',
                               allretrentdis='none', allavailrentdis='inherit', AllAvailRentals=resultsavailno)

    else:
        resultsavail = []

        cur = myConnection.cursor()
        cur.callproc('sp_GetAllAvailRentals', (stdate, enddate))
        myConnection.commit()
        result = cur.fetchall()
        for res in result:
            resultsavail.append(res)
        cur.close()
        return render_template('Rentalapp.html', custdis='none', lcustdis='none', lcardis='none', cardis='none',
                               rentdis='none', arentdis='none', retrentdis='none', lretrentdis='none',
                               AllRetRentals='none',
                               allretrentdis='none', allavailrentdis='inherit', AllAvailRentals=resultsavail)

if __name__ == '__main__':
    app.run(debug=True)
