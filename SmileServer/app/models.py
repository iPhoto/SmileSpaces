from app import db

ROLE_SUPERADMIN = 0
ROLE_ADMIN = 1
ROLE_NORMAL = 2
ROLE_FOLLOWED = 3



class City(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(255))
    maxLat = db.Column(db.String(255))
    maxLon = db.Column(db.String(255))
    minLat = db.Column(db.String(255))
    minLan = db.Column(db.String(255))
    cells = db.relationship('Cell', backref='city',
                                lazy='dynamic')

    def __repr__(self):
        return '<Group %r>' % (self.name)

    @property
    def serialize(self):
         return {
            'id'        : self.id,
            'name'      : self.name,
            'maxLat'    : self.maxLat,
            'maxLon'    : self.maxLon,
            'minLat'    : self.minLat,
            'minLon'    : self.minLon
       }


class User(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(64), unique = True)
    email = db.Column(db.String(120), unique = True)
    password = db.Column(db.String(150))
    role = db.Column(db.SmallInteger, default = ROLE_ADMIN)
    token = db.Column(db.String(240))
    phone = db.Column(db.String(20))
    active = db.Column(db.SmallInteger, default=1)
    config = db.Column(db.String(1000))
    photo = db.Column(db.String(200))

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return unicode(self.id)

    def is_admin(self):
        return True if self.role==1 else False

    def is_superadmin(self):
        return True if self.role==0 else False

    def is_(self):
        return int(self.role)

    def __repr__(self):
        return '<User %r>' % (self.email)

    @property
    def serialize(self):
         return {
            'id'        : self.id,
            'name'      : self.name,
            'email'     : self.email,
            'role'      : self.role,
            'token'     : self.token,
            'phone'     : self.phone,
            'config'    : self.config,
            'photo'     : self.photo
       }



class Data(db.Model):
    id = db.Column(db.Integer, primary_key= True)
    lat = db.Column(db.String(20))
    lon = db.Column(db.String(20))
    dataType = db.Column(db.String(50))
    dataValue = db.Column(db.String(50))
    date = db.Column(db.String(100))
    sourceId = db.Column(db.String(20))
    cell_id = db.Column(db.Integer, db.ForeignKey('cell.id'))


    def __repr__(self):
        return '<Data %r>' % (self.id)

    @property
    def serialize(self):
       return {
            'id'            : self.id,
            'value'         : self.dataValue,
            'lat'           : self.lat,
            'lon'           : self.lon,
            'dataType'      : self.dataType,
            'date'          : self.date,
            'sourceId'      : self.sourceId,
            'cell_id'       : self.cell_id
       }


class Cell(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    centerLat = db.Column(db.String(50))
    centerLon = db.Column(db.String(50))
    radius = db.Column(db.String(50))
    smileValue = db.Column(db.String(10))
    felixSecurity = db.Column(db.String(10))
    felixEnvironment = db.Column(db.String(10))
    felixOpinion = db.Column(db.String(10))
    felixCultural = db.Column(db.String(10))
    felixServices = db.Column(db.String(10))
    felixParam6 = db.Column(db.String(10))
    city_id = db.Column(db.Integer, db.ForeignKey('city.id'))
    datas = db.relationship('Data', backref='cell',
                                lazy='dynamic')

    def __repr__(self):
        return '<Cell %r>' % (self.id)

    @property
    def serialize(self):
        return {
            'id'            : self.id,
            'centerLat'     : self.centerLat,
            'centerLon'     : self.centerLon,
            'radius'        : self.radius,
            'smileValue'    : self.smileValue,
            'felixSecurity' : self.felixSecurity,
            'felixEnvironment' : self.felixEnvironment,
            'felixOpinion'  : self.felixOpinion,
            'felixCultural' : self.felixCultural,
            'felixServices' : self.felixServices,
            'felixParam6'   : self.felixParam6
        }