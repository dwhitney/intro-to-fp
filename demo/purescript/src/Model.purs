module Model where

import Prelude

import Data.Lens (Lens')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Lens.Record (prop)
import Data.Newtype (class Newtype)
import Data.Symbol (SProxy(..))

newtype FirstName = FirstName String
newtype LastName  = LastName String

type Person = 
  { firstName :: FirstName
  , lastName  :: LastName
  , address   :: Address
  }

newtype Street  = Street String
newtype City    = City String
newtype State   = State String
newtype Zip     = Zip String

type Address = 
  { street  :: Street
  , city    :: City
  , state   :: State
  , zip     :: Zip
  }

_address :: forall r. Lens' { address :: Address | r } Address 
_address = prop (SProxy  :: SProxy "address")

_street :: forall r. Lens' { street :: Street | r } String
_street = (prop (SProxy  :: SProxy "street")) <<< _Newtype

_city :: forall r. Lens' { city :: City | r } String
_city = (prop (SProxy  :: SProxy "city")) <<< _Newtype

_state :: forall r. Lens' { state :: State | r } String
_state = (prop (SProxy  :: SProxy "state")) <<< _Newtype

_zip :: forall r. Lens' { zip :: Zip | r } String
_zip = (prop (SProxy  :: SProxy "zip")) <<< _Newtype

_firstName :: forall r. Lens' { firstName :: FirstName | r } String
_firstName = (prop (SProxy  :: SProxy "firstName")) <<< _Newtype

_lastName :: forall r. Lens' { lastName :: LastName | r } String
_lastName = (prop (SProxy  :: SProxy "lastName")) <<< _Newtype



derive instance newtypeFirstName :: Newtype FirstName _
derive instance newtypeLastName :: Newtype LastName _
derive instance newtypeStreet :: Newtype Street _
derive instance newtypeState :: Newtype State _
derive instance newtypeZip :: Newtype Zip _
derive instance newtypeCity :: Newtype City _

