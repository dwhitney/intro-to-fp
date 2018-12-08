import { Applicative2 } from "fp-ts/lib/Applicative"
import { Functor2 } from "fp-ts/lib/Functor"
import { compose, flip } from "fp-ts/lib/function"
import { IO } from "fp-ts/lib/IO"
import { Lens } from "monocle-ts"

declare module "fp-ts/lib/HKT" {
  interface URI2HKT2<L,A> {
    Form: Form<L,A>
  }
}

export const URI = "Form"

export type URI = typeof URI

export type UpdateEffect<I> = (_: I) => IO<void> ;
export type UpdateUI<I> = (_: UpdateEffect<I>) => UI;
export type UI = string

export class Form<I,A>{
  readonly _tag: "Form" = "Form"
  readonly _A!: A 
  readonly _L!: I
  readonly _U!: UI 
  readonly _URI!: URI

  constructor(
    readonly update: (_: I) => { render: UpdateUI<I>, result: A }
  ){}

  ap<B>(fab: Form<I, (a: A) => B>): Form<I, B> {
    return form.ap<I,A,B>(fab, this)
  }

  ap_<B, C>(this: Form<I, (b: B) => C>, fb: Form<I, B>): Form<I, C> {
    return fb.ap(this)
  }

}

const map = <L, A, B>(form: Form<L, A>, f: (a: A) => B): Form<L, B> => 
  new Form((input) => {
    const { render, result } = form.update(input);
    return { render, result: f(result) } 
  })

const of = <L,A>(result: A): Form<L, A> => 
  new Form(() => ({ render: (_) => "", result }))

const ap = <L,A,B>(fab: Form<L,(a: A) => B>, fa: Form<L,A>): Form<L,B> =>
  new Form((input) => {
    const obj = fab.update(input);
    const { render, result } = fa.update(input);
    return { render, result : obj.result(result) };
  })

export const focus = <I,J,A>(lens: Lens<I,J>) => (form: Form<J,A>): Form<I,A> => 
 new Form((input: I) => {
  const data = form.update(lens.get(input))
  const render = (onChange: UpdateEffect<I>) =>  data.render(compose(onChange, (flip(lens.set)(input))))
  return ({ render, result: data.result })
 })

export const form: Functor2<URI> & Applicative2<URI> = { URI, map, ap, of }
