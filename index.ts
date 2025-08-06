import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from './generated/client';

const adapter = new PrismaPg({
	connectionString: process.env.DATABASE_URL,
	ssl: false,
});

const prisma = new PrismaClient({
	adapter,
	errorFormat: 'minimal',
});

Bun.serve({
	port: 3001,

	routes: {
		'/': {
			GET: async () => {
				const org = await prisma.organization.findFirst();

				return new Response(
					`Code never returns this because Prisma request above fails: ${org?.name}`,
				);
			},
		},
	},
});

console.debug('Server is running on port 3001');

process.on('SIGINT', () => {
	console.debug('Shutting down...');
	process.exit();
});
