import { Form, focus, form, UpdateEffect } from "./form"
import { Address,_city,_cityIso,_state,_stateIso,_street,_streetIso,_zip,_zipIso } from "./model"
import { Monoid } from "fp-ts/lib/Monoid"
import { liftA4 } from "fp-ts/lib/Apply"
 
export const textBox = <UI>(result: string): Form<UI,string,string> =>
  new Form((_: string) => ({ render: (M: Monoid<UI>) => (_: UpdateEffect<string>) => M.empty, result }))

export const numberBox = <UI>(result: number): Form<UI,number,number> =>
  new Form((_: number) => ({ render: (M: Monoid<UI>) => (_ : UpdateEffect<number>) => M.empty, result }))

export const cityField = <UI>(): Form<UI,Address,string> => 
  focus<UI,Address,string,string>(_city.composeIso(_cityIso))(textBox<UI>("")) 

export const stateField = <UI>(): Form<UI,Address,string> =>
  focus<UI,Address,string,string>(_state.composeIso(_stateIso))(textBox(""))

export const streetField = <UI>(): Form<UI,Address,string> =>
  focus<UI,Address,string,string>(_street.composeIso(_streetIso))(textBox(""))

export const zipField = <UI>(): Form<UI,Address,number> =>
  focus<UI,Address,number,number>(_zip.composeIso(_zipIso))(numberBox(0))

const makeAddress = (city: string) => (state: string) => (street: string) => (zip: number): Address => 
  ({ city: _cityIso.wrap(city), state: _stateIso.wrap(state), zip: _zipIso.wrap(zip), street : _streetIso.wrap(street) })

export const addressForm = <UI>(): Form<UI, Address, Address> =>
  liftA4(form)(makeAddress)(cityField<UI>())(stateField<UI>())(streetField<UI>())(zipField<UI>())

/*
export const addressForm: Form<Address,Address> = 
  form.of<(string => string => Address),Address>(makeAddress)
      .ap_<(string => string => Address),(string => Address)>(cityField)
      .ap_<(string => Address),Address>(stateField)
*/ 
