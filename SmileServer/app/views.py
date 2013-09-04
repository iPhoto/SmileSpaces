from app import app, db
from models import User, City, Data, Cell
from flask import render_template, flash, redirect, session, url_for, request, g, Response, jsonify
from flask import make_response, abort

@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route('/')
def index3():
    return "Hello, User!"



### CITY API ###
#Get all Cities
@app.route('/api/1/City', methods=['GET'])
def getCity():
    try:
        cities = City.query.all()
        if(cities):
            return jsonify(results=[item.serialize for item in cities])
        else:
            return make_response(jsonify( { 'error': 'Unauthorized access' } ), 406)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)

#Get city by ID
@app.route('/api/1/City/<cityID>', methods=['GET'])
def getCityById(cityID):
    try:
        city = City.query.filter_by(id=cityID).first()
        if(city):
            return city.serialize
        else:
            return make_response(jsonify( { 'error': 'Unauthorized access' } ), 406)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)

#Create new city
@app.route('/api/1/City', methods=['POST'])
def postCity():
    try:
        city = City()
        if "name" in request.form: city.name = request.form["name"]
        if "maxLat" in request.form: city.pack = request.form["maxLat"]
        if "maxLon" in request.form: city.pack = request.form["maxLon"]
        if "minLat" in request.form: city.pack = request.form["minLat"]
        if "minLon" in request.form: city.pack = request.form["minLon"]

        db.session.add(city)
        db.session.commit()
        return make_response(jsonify( { 'ok': 'city created' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)

#Update existing city
@app.route('/api/1/City/<cityID>', methods=['PUT'])
def putCity(cityID):
    try:
        city = City.query.filter_by(id=cityID).first()
        if "name" in request.form: city.name = request.form["name"]
        if "maxLat" in request.form: city.pack = request.form["maxLat"]
        if "maxLon" in request.form: city.pack = request.form["maxLon"]
        if "minLat" in request.form: city.pack = request.form["minLat"]
        if "minLon" in request.form: city.pack = request.form["minLon"]

        db.session.commit()
        return make_response(jsonify( { 'ok': 'group updated' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)

#Delete an existing
@app.route('/api/1/City/<cityID>', methods=['DELETE'])
def deleteCity(cityID):
    try:
        city = City.query.filter_by(id=cityID).first()
        db.session.delete(cityID)
        db.session.commit()
        return make_response(jsonify( { 'ok': 'group updated' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#### DATA API ####
#Get data by ID
@app.route('/api/1/Data/<cellID>', methods=['GET'])
def getDataByCellId(cellID):
    try:
        datas = Data.query.filter_by(cell_id = cellID).all()
        if(datas):
            return jsonify(results=[item.serialize for item in datas])
        else:
            return make_response(jsonify( { 'error': 'Unauthorized access' } ), 406)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#Create a new Data
@app.route('/api/1/Data', methods=['POST'])
def postData():
    try:
        data = Data()
        #TODO: Complete
        db.session.add(data)
        db.session.commit()
        return make_response(jsonify( { 'ok': 'Data created' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#Update an existing Data
@app.route('/api/1/Data/<dataId>', methods=['PUT'])
def putData(dataId):
    try:
        data = Data.query.filter_by(id=dataId).first()
        #TODO: Complete method
        db.session.commit()
        return make_response(jsonify( { 'ok': 'data updated' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#Delete existing Data
@app.route('/api/1/Data/<dataId>', methods=['DELETE'])
def deleteData(dataId):
    try:
        data = Data.query.filter_by(id=dataId).first()
        db.session.delete(data)
        db.session.commit()
        return make_response(jsonify( { 'ok': 'data updated' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)



#### Cell API ####
#Get all cells of a City
@app.route('/api/1/Cell/City/<int:cityId>', methods=['GET'])
def getCellsByCity(cityId):
    try:
        cells = Cell.query.filter_by(city_id = cityId).all()
        if(cells):
            return jsonify(results=[item.serialize for item in cells])
        else:
            return make_response(jsonify( { 'error': 'Unauthorized access' } ), 406)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#Get city
@app.route('/api/1/Cell/<cellId>', methods=['GET'])
def getCell(cellID):
    try:
        cell = Cell.query.filter_by(id = cellID).all()
        if(cell):
            return jsonify(results=cell.serialize)
        else:
            return make_response(jsonify( { 'error': 'Unauthorized access' } ), 406)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)



#Create a new cell
@app.route('/api/1/Cell', methods=['POST'])
def postCell():
    try:
        data = Cell()
        #TODO: Complete
        return make_response(jsonify( { 'ok': 'Cell created' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#Update an existing Cell
@app.route('/api/1/Cell/<cellId>', methods=['PUT'])
def putCell(cellId):
    try:
        data = Data.query.filter_by(id=cellId).first()
        #TODO: Complete method
        return make_response(jsonify( { 'ok': 'data updated' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)


#Delete existing Cell
@app.route('/api/1/Cell/<cellId>', methods=['DELETE'])
def deleteGroup(cellId):
    try:
        data = Data.query.filter_by(id=cellId).first()
        db.session.delete(data)
        db.session.commit()
        return make_response(jsonify( { 'ok': 'data updated' } ), 200)
    except:
        return make_response(jsonify( { 'error': 'Server Error' } ), 500)
