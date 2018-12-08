import { Form, focus, form, UpdateEffect } from "./form"
import { Address,_city,_cityIso,_state,_stateIso,_street,_streetIso,_zip,_zipIso } from "./model"
import { liftA4 } from "fp-ts/lib/Apply"
 
export const textBox : Form<string,string> =
  new Form((_: string) => ({ render: (_: UpdateEffect<string>) => "", result : "" }))

export const numberBox : Form<number,number> =
  new Form((_: number) => ({ render: (_: UpdateEffect<number>) => "", result : 0 }))

export const cityField = 
  focus<Address,string,string>(_city.composeIso(_cityIso))(textBox) 

export const stateField = 
  focus<Address,string,string>(_state.composeIso(_stateIso))(textBox)

export const streetField = 
  focus<Address,string,string>(_street.composeIso(_streetIso))(textBox)

export const zipField = 
  focus<Address,number,number>(_zip.composeIso(_zipIso))(numberBox)


const makeAddress = (city: string) => (state: string) => (street: string) => (zip: number): Address => 
  ({ city: _cityIso.wrap(city), state: _stateIso.wrap(state), zip: _zipIso.wrap(zip), street : _streetIso.wrap(street) })

export const addressForm: Form<Address,Address> =
  liftA4(form)(makeAddress)(cityField)(stateField)(streetField)(zipField)

/*
export const addressForm: Form<Address,Address> = 
  form.of<(string => string => Address),Address>(makeAddress)
      .ap_<(string => string => Address),(string => Address)>(cityField)
      .ap_<(string => Address),Address>(stateField)
*/ 
