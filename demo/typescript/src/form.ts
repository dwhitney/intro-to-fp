import { Applicative3 } from "fp-ts/lib/Applicative"
import { Functor3 } from "fp-ts/lib/Functor"
import { compose, flip } from "fp-ts/lib/function"
import { IO } from "fp-ts/lib/IO"
import { Monoid } from "fp-ts/lib/Monoid"
import { Lens } from "monocle-ts"

declare module "fp-ts/lib/HKT" {
  interface URI2HKT3<U,L,A> {
    Form: Form<U,L,A>
  }
}

export const URI = "Form"

export type URI = typeof URI

export type UpdateEffect<I> = (_: I) => IO<void> ;
export type UpdateUI<UI,I> = (_: Monoid<UI>) => (_: UpdateEffect<I>) => UI;
//export type UI = string

export class Form<UI,I,A>{
  readonly _tag: "Form" = "Form"
  readonly _A!: A 
  readonly _L!: I
  readonly _U!: UI 
  readonly _URI!: URI

  constructor(
    readonly update: (_: I) => { render: UpdateUI<UI,I>, result: A }
  ){}

  ap<B>(fab: Form<UI,I, (a: A) => B>): Form<UI,I, B> {
    return form.ap<UI,I,A,B>(fab, this)
  }

  ap_<B, C>(this: Form<UI,I, (b: B) => C>, fb: Form<UI,I, B>): Form<UI,I, C> {
    return fb.ap(this)
  }

}

const map = <UI,L, A, B>(form: Form<UI,L, A>, f: (a: A) => B): Form<UI,L, B> => 
  new Form((input) => {
    const { render, result } = form.update(input);
    return { render, result: f(result) } 
  })

const of = <UI,L,A>(result: A): Form<UI,L, A> => 
  new Form(() => ({ render: (m: Monoid<UI>) => (_) => m.empty, result }))

const ap = <UI,L,A,B>(fab: Form<UI,L,(a: A) => B>, fa: Form<UI,L,A>): Form<UI,L,B> =>
  new Form((input) => {
    const obj = fab.update(input);
    const { render, result } = fa.update(input);
    return { render, result : obj.result(result) };
  })

export const focus = <UI,I,J,A>(lens: Lens<I,J>) => (form: Form<UI,J,A>): Form<UI,I,A> => 
 new Form((input: I) => {
  const data = form.update(lens.get(input))
  const render = (m: Monoid<UI>) => (onChange: UpdateEffect<I>) => data.render(m)(compose(onChange, (flip(lens.set)(input))))
  return ({ render, result: data.result })
 })

export const form: Functor3<URI> & Applicative3<URI> = { URI, map, ap, of }
