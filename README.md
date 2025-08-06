# prisma-27754-bug

To reproduce issue:

1. Update `.env` with a Postgres database you can connect to and push the Prisma schema to that DB
2. Build Docker image: `docker build --progress=plain -f Dockerfile .`
3. Run Docker image: `docker run -e NODE_ENV=production -p 8080:8080 <image_id>`
4. Open http://localhost:3001 in a browser

You'll get this failure:

```
Server is running on port 3001
10 | ${Y.map((H)=>`  ${T_(H)}`).join(`
11 | `)}
12 | 
13 | We suggest to move the contents of ${D_(W)} to ${D_(K)} to consolidate your env vars.
14 | `;throw new Error($)}else if(J==="warn"){let $=`Conflict for env var${Y.length>1?"s":""} ${Y.map((H)=>T_(H)).join(", ")} in ${D_(K)} and ${D_(W)}
15 |       `;console.warn(`${r1("warn(prisma)")} ${$}`)}}}}function n5(_){if(NK(_)){O8(`Environment variables loaded from ${_}`);let X=R3.default.config({path:_,debug:process.env.DOTENV_CONFIG_DEBUG?!0:void 0});return{dotenvResult:LK(X),message:n1(`Environment variables loaded from ${X1.default.relative(process.cwd(),_)}`),path:_}}else O8(`Environment variables not found at ${_}`);return null}function F3(_,X){return _&&X&&X1.default.resolve(_)===X1.default.resolve(X)}function NK(_){return!!(_&&j8.default.existsSync(_))}function qK(_,X){return Object.prototype.hasOwnProperty.call(_,X)}function h8(_,X){let J={};for(let U of Object.keys(_))J[U]=X(_[U],U);return J}function DK(_,X){if(_.length===0)return;let J=_[0];for(let U=1;U<_.length;U++)X(J,_[U])<0&&(J=_[U]);return J}function __(_,X){Object.defineProperty(_,"name",{value:X,configurable:!0})}var r5=new Set,M3=(_,X,...J)=>{r5.has(_)||(r5.add(_),O3(X,...J))},Z_=class _ extends Error{clientVersion;errorCode;retryable;constructor(X,J,U){super(X),this.name="PrismaClient

PrismaClientKnownRequestError: 
Invalid `prisma.organization.findFirst()` invocation:


Cannot find module '@prisma/client/runtime/query_compiler_bg.postgresql.wasm' from '/$bunfs/root/repro'
       meta: {
  modelName: "Organization",
},
 clientVersion: "6.14.0-integration-feat-client-wasm-base64-on-nodejs.6",
       code: "MODULE_NOT_FOUND"

      at new PrismaClientKnownRequestError (/$bunfs/root/repro:15:1352)
      at handleRequestError (/$bunfs/root/repro:83:7493)
      at handleAndLogRequestError (/$bunfs/root/repro:83:6835)
      at request (/$bunfs/root/repro:83:6548)
```