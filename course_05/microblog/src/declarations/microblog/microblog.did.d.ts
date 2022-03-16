import type { Principal } from '@dfinity/principal';
export interface Message {
  'content' : string,
  'author' : [] | [string],
  'timestamp' : bigint,
}
export type Time = bigint;
export interface _SERVICE {
  'follow' : (arg_0: string, arg_1: Principal) => Promise<undefined>,
  'follows' : () => Promise<Array<Principal>>,
  'get_name' : () => Promise<[] | [string]>,
  'post' : (arg_0: string, arg_1: string) => Promise<undefined>,
  'posts' : (arg_0: Time) => Promise<Array<Message>>,
  'set_name' : (arg_0: string, arg_1: string) => Promise<undefined>,
  'timeline' : (arg_0: Time) => Promise<Array<Message>>,
}
